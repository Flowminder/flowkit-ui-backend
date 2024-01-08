# This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

import structlog
import os
import httpx
from typing import Optional
from http import HTTPStatus
from aiomysql import Pool
from fastapi import HTTPException
from flowkit_ui_backend.models.extra_models import TokenModel
from flowkit_ui_backend.models.user_metadata import UserMetadata
from auth0.asyncify import asyncify
from auth0.management import Auth0
from auth0.authentication import GetToken


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
    auth0_domain: str,
    auth0_client_id: str,
    auth0_client_secret: str,
    pool: Pool = None,
    token_model: TokenModel = None,
) -> UserMetadata:
    user = await Auth0(
        auth0_domain,
        await get_management_api_m2m_token(
            auth0_domain=auth0_domain,
            auth0_client_id=auth0_client_id,
            auth0_client_secret=auth0_client_secret.get_secret_value(),
        ),
    ).users.get_async(uid)
    if user is None:
        raise HTTPException(status_code=HTTPStatus.NOT_FOUND, detail="User not found")
    return user


async def update_user(
    uid: str,
    body: UserMetadata,
    auth0_domain: str,
    auth0_client_id: str,
    auth0_client_secret: str,
    pool: Pool = None,
    token_model: TokenModel = None,
) -> None:
    await Auth0(
        auth0_domain,
        await get_management_api_m2m_token(
            auth0_domain=auth0_domain,
            auth0_client_id=auth0_client_id,
            auth0_client_secret=auth0_client_secret.get_secret_value(),
        ),
    ).users.update_async(uid, {"user_metadata": body.dict()})


async def delete_user(
    uid: str,
    auth0_domain: str,
    auth0_client_id: str,
    auth0_client_secret: str,
    pool: Pool = None,
    token_model: TokenModel = None,
) -> None:
    await Auth0(
        auth0_domain,
        await get_management_api_m2m_token(
            auth0_domain=auth0_domain,
            auth0_client_id=auth0_client_id,
            auth0_client_secret=auth0_client_secret.get_secret_value(),
        ),
    ).users.delete_async(uid)


async def reset_password(
    email: str,
    auth0_domain: str,
    auth0_client_id: str,
    pool: Pool = None,
    token_model: TokenModel = None,
) -> None:
    response = httpx.post(
        url=f"https://{auth0_domain}/dbconnections/change_password",
        headers={"Content-Type": "application/json"},
        data=f'{{"client_id": "{auth0_client_id}", "email": "{email}", "connection": "Username-Password-Authentication"}}',
    )
    if response.status_code != HTTPStatus.OK:
        raise HTTPException(
            status_code=HTTPStatus.INTERNAL_SERVER_ERROR,
            detail=f"Could not trigger password reset for email {email}",
        )


async def get_management_api_m2m_token(
    auth0_domain: str, auth0_client_id: str, auth0_client_secret: str
) -> Optional[str]:
    try:
        # - obtain m2m access token for management API using the flowkit_ui_backend's client grant as set in Auth0 dashboard
        get_token = asyncify(GetToken)(auth0_domain)
        token = await get_token.client_credentials_async(
            auth0_client_id,
            auth0_client_secret.get_secret_value(),
            f"https://{auth0_domain}/api/v2/",
        )
        return token["access_token"]
    except Exception as e:
        logger.error(f"Could not obtain M2M token: {e}")
        return None
