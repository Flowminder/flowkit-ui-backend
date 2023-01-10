# This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

import structlog
import os
from typing import Optional
from http import HTTPStatus
from aiomysql import Pool
from fastapi import HTTPException
from dotenv import load_dotenv
from flowkit_ui_backend.models.user_metadata import UserMetadata
from auth0.v3.asyncify import asyncify
from auth0.v3.management import Auth0
from auth0.v3.authentication import GetToken

load_dotenv()

logger = structlog.get_logger("flowkit_ui_backend.log")


# A note on tokens:
# We can't re-use the user's token they obtained from the UI as the audience for that is this API,
# not the Auth0 management API. Instead, we just use the user's token for validation via our security_api.
# If the user lacked the permission for the requested endpoint, an exception would have been thrown
# before we even get here so we can assume the user is legitimate and authorised.
# Given that, we can simply let the flowkit_ui_backend (client) obtain a M2M token for the management API
# and use that to execute the request.


async def get_user(uid: str, pool: Pool = None) -> UserMetadata:
    user = await Auth0(
        os.getenv("AUTH0_DOMAIN"), await get_management_api_m2m_token()
    ).users.get_async(uid)
    if user is None:
        raise HTTPException(status_code=HTTPStatus.NOT_FOUND, detail="User not found")
    return user


async def update_user(uid: str, body: UserMetadata, pool: Pool = None) -> None:
    await Auth0(os.getenv("AUTH0_DOMAIN"), await get_management_api_m2m_token()).users.update_async(
        uid, {"user_metadata": body.dict()}
    )


async def delete_user(uid: str, pool: Pool = None) -> None:
    await Auth0(os.getenv("AUTH0_DOMAIN"), await get_management_api_m2m_token()).users.delete_async(
        uid
    )


async def get_management_api_m2m_token() -> Optional[str]:

    try:
        # - obtain m2m access token for management API using the flowkit_ui_backend's client grant as set in Auth0 dashboard
        get_token = asyncify(GetToken)(os.getenv("AUTH0_DOMAIN"))
        token = await get_token.client_credentials_async(
            os.getenv("AUTH0_CLIENT_ID"),
            os.getenv("AUTH0_CLIENT_SECRET"),
            f"https://{os.getenv('AUTH0_DOMAIN')}/api/v2/",
        )
        return token["access_token"]
    except Exception as e:
        logger.error(f"Could not obtain M2M token: {e}")
        return None
