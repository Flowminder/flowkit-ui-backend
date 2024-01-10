# This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

# coding: utf-8

import os
import structlog
from typing import List, Optional

from auth0.authentication.async_token_verifier import AsyncAsymmetricSignatureVerifier
from fastapi import Depends, Security  # noqa: F401
from fastapi.openapi.models import OAuthFlowImplicit, OAuthFlows  # noqa: F401
from fastapi.security import (  # noqa: F401
    HTTPAuthorizationCredentials,
    HTTPBasic,
    HTTPBasicCredentials,
    HTTPBearer,
    OAuth2,
    OAuth2AuthorizationCodeBearer,
    OAuth2PasswordBearer,
    SecurityScopes,
)
from fastapi.security.api_key import (
    APIKeyCookie,
    APIKeyHeader,
    APIKeyQuery,
)  # noqa: F401

from flowkit_ui_backend.models.extra_models import TokenModel

logger = structlog.get_logger("flowkit_ui_backend.log")

oauth2_code = OAuth2AuthorizationCodeBearer(
    authorizationUrl="https://flowminder-dev.eu.auth0.com/authorize",
    tokenUrl="https://flowminder-dev.eu.auth0.com/token",
    refreshUrl="",
    scopes={
        "profile": "Read, edit and delete your account, profile and settings for this application",
        "read:free_data": "Get the free data",
        "read:premium_data": "Get the premium data",
        "write:data": "Add and modify data",
        "admin": "Modify config",
    },
)

# TODO: ideally move this to the app startup
sv = AsyncAsymmetricSignatureVerifier(
    f"https://{os.getenv('AUTH0_DOMAIN')}/.well-known/jwks.json"
)


async def get_token_auth0(
    security_scopes: SecurityScopes, token: str = Depends(oauth2_code)
) -> TokenModel:
    """
    Validate and decode token.

    :param token Token provided by Authorization header
    :type token: str
    :return: Decoded token information or None if token is invalid
    :rtype: TokenModel | None
    """

    logger.debug(
        "Validate token",
        client_id=os.getenv("AUTH0_AUDIENCE"),
        domain=os.getenv("AUTH0_DOMAIN"),
    )

    try:
        # TODO: this currently only works for ID tokens, not access tokens; see https://github.com/auth0/auth0-PHP/issues/422
        # eventually we should use AsyncTokenVerifier instead of AsyncAsymmetricSignatureVerifier
        # see https://github.com/auth0/auth0-python/tree/f15520b8390ee7ba131a2dc45b0f96591b96bd95#id-token-validation
        # tv = AsyncTokenVerifier(signature_verifier=sv, issuer=f"https://{os.getenv('AUTH0_DOMAIN')}/", audience=os.getenv('AUTH0_AUDIENCE'))
        # claims = await tv.verify(token)
        claims = await sv.verify_signature(token)
    except Exception as e:
        logger.error(e)
        raise PermissionError(f"Could not decode token")

    logger.debug("Checking claims", claims=claims)
    valid = validate_scope_auth0(security_scopes.scopes, claims)
    if not valid:
        raise PermissionError(
            f"Invalid token: Required permissions {security_scopes.scopes} not present"
        )

    return TokenModel(sub=claims["sub"], permissions=claims["permissions"])


def validate_scope_auth0(required_scopes: SecurityScopes, claims: dict) -> bool:
    """
    Validate required scopes are included in token scope

    :param required_scopes Required scope to access called API
    :type required_scopes: List[str]
    :param claims Token claims, including scopes
    :type claims: dict
    :return: True if access to called API is allowed
    :rtype: bool
    """

    token_scopes = claims["scope"].split(
        " "
    )  # We want to check scope here, rather than permission
    valid = all(item in token_scopes for item in required_scopes)
    logger.debug(
        f"Validating scopes",
        valid=valid,
        required=required_scopes,
        received=token_scopes,
    )

    return valid
