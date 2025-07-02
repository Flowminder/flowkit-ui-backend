# This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

import structlog
import httpx
from typing import Optional, Annotated
from http import HTTPStatus
from aiomysql import Pool
from auth0.management.async_auth0 import AsyncAuth0
from asyncache import cached
from cachetools import TTLCache
from fastapi import HTTPException
from fastapi.params import Depends
from pydantic.v1 import SecretStr

from flowkit_ui_backend.models.extra_models import TokenModel
from flowkit_ui_backend.models.user_metadata import UserMetadata
from auth0.asyncify import asyncify
from auth0.management import Auth0
from auth0.authentication import GetToken

from flowkit_ui_backend.util.config import SettingsDep

logger = structlog.get_logger("flowkit_ui_backend.log")


# A note on tokens:
# We can't re-use the user's token they obtained from the UI as the audience for that is this API,
# not the Auth0 management API. Instead, we just use the user's token for validation via our security_api.
# If the user lacked the permission for the requested endpoint, an exception would have been thrown
# before we even get here so we can assume the user is legitimate and authorised.
# Given that, we can simply let the flowkit_ui_backend (client) obtain a M2M token for the management API
# and use that to execute the request.


async def get_user(
    uid: str,
    auth0: Auth0,
    pool: Pool = None,
    token_model: TokenModel = None,
) -> UserMetadata:
    user = await auth0.users.get_async(uid)
    if user is None:
        raise HTTPException(status_code=HTTPStatus.NOT_FOUND, detail="User not found")
    return user


async def update_user(
    uid: str,
    body: UserMetadata,
    auth0: Auth0,
    pool: Pool = None,
    token_model: TokenModel = None,
) -> None:
    await auth0.users.update_async(uid, {"user_metadata": body.dict()})


async def delete_user(
    uid: str,
    auth0: Auth0,
    pool: Pool = None,
    token_model: TokenModel = None,
) -> None:
    await auth0.users.delete_async(uid)


async def reset_password(
    email: str,
    auth0_domain: str,
    auth0_client_id: str,
    pool: Pool = None,
    token_model: TokenModel = None,
) -> None:
    async with httpx.AsyncClient() as cl:
        response = await cl.post(
            url=f"https://{auth0_domain}/dbconnections/change_password",
            headers={"Content-Type": "application/json"},
            data={
                "client_id": auth0_client_id,
                "email": email,
                "connection": "Username-Password-Authentication",
            },
        )
        if response.status_code != HTTPStatus.OK:
            raise HTTPException(
                status_code=HTTPStatus.INTERNAL_SERVER_ERROR,
                detail=f"Could not trigger password reset for email {email}",
            )


@cached(TTLCache(2, 86400))
async def get_management_api_m2m_token(
    auth0_domain: str, auth0_client_id: str, auth0_client_secret: str
) -> Optional[str]:
    logger.debug("Getting m2m token.")
    try:
        # - obtain m2m access token for management API using the flowkit_ui_backend's client grant as set in Auth0 dashboard
        get_token = asyncify(GetToken)(
            auth0_domain, auth0_client_id, auth0_client_secret
        )
        token = await get_token.client_credentials_async(
            f"https://{auth0_domain}/api/v2/",
        )
        return token["access_token"]
    except Exception as e:
        logger.error(f"Could not obtain M2M token: {e}")
        return None


async def management_api_m2m_token(settings: SettingsDep) -> Optional[str]:
    logger.debug("Getting m2m token.")
    return await get_management_api_m2m_token(
        auth0_domain=settings.auth0_domain,
        auth0_client_id=settings.auth0_client_id,
        auth0_client_secret=settings.auth0_client_secret.get_secret_value(),
    )


async def auth0_management(
    settings: SettingsDep,
    management_token: Annotated[str, Depends(management_api_m2m_token)],
) -> AsyncAuth0:
    logger.debug("Getting auth0 connection.")
    return AsyncAuth0(
        settings.auth0_domain,
        management_token,
    )
