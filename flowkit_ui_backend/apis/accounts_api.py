# This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.
from typing import Annotated

# coding: utf-8

import structlog
import traceback
from http import HTTPStatus

from auth0.management import Auth0
from fastapi.responses import ORJSONResponse, JSONResponse
from fastapi.encoders import jsonable_encoder
from fastapi import (  # noqa: F401
    APIRouter,
    Body,
    Cookie,
    Depends,
    Form,
    Header,
    HTTPException,
    Path,
    Query,
    Request,
    Response,
    Security,
    status,
)

from flowkit_ui_backend.util import gzip
from flowkit_ui_backend.models.extra_models import TokenModel  # noqa: F401
from flowkit_ui_backend.models.user_metadata import UserMetadata
from flowkit_ui_backend.security_api import get_token_auth0
from flowkit_ui_backend.impl import accounts_api_impl
from flowkit_ui_backend.util.config import get_settings, Settings

router = APIRouter(route_class=gzip.GzipRoute)
logger = structlog.get_logger("flowkit_ui_backend.log")


@router.delete(
    "/users/{uid}",
    responses={
        204: {"description": "OK: The request was successful."},
        400: {
            "description": "Bad Request: The request is malformed, incomplete or otherwise invalid."
        },
        401: {
            "description": "Unauthorized: The user does not have the permissions to access this resource."
        },
        404: {"description": "Not Found: The requested data could not be found."},
        429: {
            "description": "Too Many Requests: The user has exceeded the limit of allowed simultaneous requests."
        },
        500: {
            "description": "Internal Server Error: Something went wrong on the server while retrieving the data."
        },
        503: {
            "description": "Service Unavailable: The server is currently down, e.g. for maintenance. Please try again later."
        },
    },
    tags=["accounts"],
    response_class=ORJSONResponse,
)
async def delete_user(
    auth0_management: Annotated[Auth0, Depends(accounts_api_impl.auth0_management)],
    uid: str = Path(description="The user ID"),
    token_auth0: TokenModel = Security(get_token_auth0, scopes=["profile"]),
    request: Request = None,
) -> None:
    """Deletes a single user"""

    if not hasattr(accounts_api_impl, "delete_user") or not callable(
        getattr(accounts_api_impl, "delete_user")
    ):
        raise NotImplementedError("The /delete_user endpoint is not yet implemented")

    try:
        logger.debug("Starting request")
        impl_result = await accounts_api_impl.delete_user(
            uid,
            pool=request.app.state.pool,
            token_model=token_auth0,
            auth0=auth0_management,
        )
        logger.debug("Request ready")
        content = impl_result[0] if isinstance(impl_result, tuple) else impl_result
        if isinstance(impl_result, Response):
            return impl_result
        # default to status 200/204 but give the impl the option to define a different status code when returning content
        status_code = impl_result[1] if isinstance(impl_result, tuple) else None
        if content is not None:
            return ORJSONResponse(
                status_code=status_code if status_code is not None else HTTPStatus.OK,
                content=jsonable_encoder(content),
            )
        else:
            return Response(
                status_code=status_code
                if status_code is not None
                else HTTPStatus.NO_CONTENT
            )

    # This is where we handle status codes via exceptions as raised by the impl methods
    except HTTPException as e:
        logger.debug(
            "Request failed",
            code=e.status_code,
            content=e.detail,
            traceback=traceback.print_exception(type(e), e, e.__traceback__),
        )
        return JSONResponse(status_code=e.status_code, content=e.detail)
    except Exception as e:
        logger.error(e)
        traceback.print_exception(type(e), e, e.__traceback__)
        return JSONResponse(
            status_code=HTTPStatus.INTERNAL_SERVER_ERROR,
            content=f"Something went wrong: {e}",
        )


@router.get(
    "/users/{uid}",
    responses={
        200: {
            "model": UserMetadata,
            "description": "OK: The user exists and their metadata is returned in the content part of this response.",
        },
        400: {
            "description": "Bad Request: The request is malformed, incomplete or otherwise invalid."
        },
        401: {
            "description": "Unauthorized: The user does not have the permissions to access this resource."
        },
        404: {"description": "Not Found: The requested data could not be found."},
        429: {
            "description": "Too Many Requests: The user has exceeded the limit of allowed simultaneous requests."
        },
        500: {
            "description": "Internal Server Error: Something went wrong on the server while retrieving the data."
        },
        503: {
            "description": "Service Unavailable: The server is currently down, e.g. for maintenance. Please try again later."
        },
    },
    tags=["accounts"],
    response_class=ORJSONResponse,
)
async def get_user(
    auth0_management: Annotated[Auth0, Depends(accounts_api_impl.auth0_management)],
    uid: str = Path(description="The user ID"),
    token_auth0: TokenModel = Security(get_token_auth0, scopes=["profile"]),
    request: Request = None,
) -> UserMetadata:
    """Gets information about a single user"""

    if not hasattr(accounts_api_impl, "get_user") or not callable(
        getattr(accounts_api_impl, "get_user")
    ):
        raise NotImplementedError("The /get_user endpoint is not yet implemented")

    try:
        logger.debug("Starting request")
        impl_result = await accounts_api_impl.get_user(
            uid,
            pool=request.app.state.pool,
            token_model=token_auth0,
            auth0=auth0_management,
        )
        logger.debug("Request ready")
        content = impl_result[0] if isinstance(impl_result, tuple) else impl_result
        if isinstance(impl_result, Response):
            return impl_result
        # default to status 200/204 but give the impl the option to define a different status code when returning content
        status_code = impl_result[1] if isinstance(impl_result, tuple) else None
        if content is not None:
            return ORJSONResponse(
                status_code=status_code if status_code is not None else HTTPStatus.OK,
                content=jsonable_encoder(content),
            )
        else:
            return Response(
                status_code=status_code
                if status_code is not None
                else HTTPStatus.NO_CONTENT
            )

    # This is where we handle status codes via exceptions as raised by the impl methods
    except HTTPException as e:
        logger.debug(
            "Request failed",
            code=e.status_code,
            content=e.detail,
            traceback=traceback.print_exception(type(e), e, e.__traceback__),
        )
        return JSONResponse(status_code=e.status_code, content=e.detail)
    except Exception as e:
        logger.error(e)
        traceback.print_exception(type(e), e, e.__traceback__)
        return JSONResponse(
            status_code=HTTPStatus.INTERNAL_SERVER_ERROR,
            content=f"Something went wrong: {e}",
        )


@router.get(
    "/reset_password/{email}",
    responses={
        204: {
            "description": "OK: The password reset has been initiated and the suer should check their email for further instructions."
        },
        400: {
            "description": "Bad Request: The request is malformed, incomplete or otherwise invalid."
        },
        401: {
            "description": "Unauthorized: The user does not have the permissions to access this resource."
        },
        404: {"description": "Not Found: The requested data could not be found."},
        429: {
            "description": "Too Many Requests: The user has exceeded the limit of allowed simultaneous requests."
        },
        500: {
            "description": "Internal Server Error: Something went wrong on the server while retrieving the data."
        },
        503: {
            "description": "Service Unavailable: The server is currently down, e.g. for maintenance. Please try again later."
        },
    },
    tags=["accounts"],
    response_class=ORJSONResponse,
)
async def reset_password(
    settings: Annotated[Settings, Depends(get_settings)],
    email: str = Path(description="The user&#39;s email address"),
    token_auth0: TokenModel = Security(get_token_auth0, scopes=["profile"]),
    request: Request = None,
) -> None:
    """Triggers a password reset for the user"""

    if not hasattr(accounts_api_impl, "reset_password") or not callable(
        getattr(accounts_api_impl, "reset_password")
    ):
        raise NotImplementedError("The /reset_password endpoint is not yet implemented")

    try:
        logger.debug("Starting request")
        impl_result = await accounts_api_impl.reset_password(
            email,
            pool=request.app.state.pool,
            token_model=token_auth0,
            auth0_domain=settings.auth0_domain,
            auth0_client_id=settings.auth0_client_id,
        )
        logger.debug("Request ready")
        content = impl_result[0] if isinstance(impl_result, tuple) else impl_result
        if isinstance(impl_result, Response):
            return impl_result
        # default to status 200/204 but give the impl the option to define a different status code when returning content
        status_code = impl_result[1] if isinstance(impl_result, tuple) else None
        if content is not None:
            return ORJSONResponse(
                status_code=status_code if status_code is not None else HTTPStatus.OK,
                content=jsonable_encoder(content),
            )
        else:
            return Response(
                status_code=status_code
                if status_code is not None
                else HTTPStatus.NO_CONTENT
            )

    # This is where we handle status codes via exceptions as raised by the impl methods
    except HTTPException as e:
        logger.debug(
            "Request failed",
            code=e.status_code,
            content=e.detail,
            traceback=traceback.print_exception(type(e), e, e.__traceback__),
        )
        return JSONResponse(status_code=e.status_code, content=e.detail)
    except Exception as e:
        logger.error(e)
        traceback.print_exception(type(e), e, e.__traceback__)
        return JSONResponse(
            status_code=HTTPStatus.INTERNAL_SERVER_ERROR,
            content=f"Something went wrong: {e}",
        )


@router.patch(
    "/users/{uid}",
    responses={
        204: {"description": "OK: The request was successful."},
        400: {
            "description": "Bad Request: The request is malformed, incomplete or otherwise invalid."
        },
        401: {
            "description": "Unauthorized: The user does not have the permissions to access this resource."
        },
        404: {"description": "Not Found: The requested data could not be found."},
        429: {
            "description": "Too Many Requests: The user has exceeded the limit of allowed simultaneous requests."
        },
        500: {
            "description": "Internal Server Error: Something went wrong on the server while retrieving the data."
        },
        503: {
            "description": "Service Unavailable: The server is currently down, e.g. for maintenance. Please try again later."
        },
    },
    tags=["accounts"],
    response_class=ORJSONResponse,
)
async def update_user(
    auth0_management: Annotated[Auth0, Depends(accounts_api_impl.auth0_management)],
    uid: str = Path(description="The user ID"),
    user_metadata: UserMetadata = Body(None, description="The user to update"),
    token_auth0: TokenModel = Security(get_token_auth0, scopes=["profile"]),
    request: Request = None,
) -> None:
    """Updates a user&#39;s metadata"""

    if not hasattr(accounts_api_impl, "update_user") or not callable(
        getattr(accounts_api_impl, "update_user")
    ):
        raise NotImplementedError("The /update_user endpoint is not yet implemented")

    try:
        logger.debug("Starting request")
        impl_result = await accounts_api_impl.update_user(
            uid,
            user_metadata,
            pool=request.app.state.pool,
            token_model=token_auth0,
            auth0=auth0_management,
        )
        logger.debug("Request ready")
        content = impl_result[0] if isinstance(impl_result, tuple) else impl_result
        if isinstance(impl_result, Response):
            return impl_result
        # default to status 200/204 but give the impl the option to define a different status code when returning content
        status_code = impl_result[1] if isinstance(impl_result, tuple) else None
        if content is not None:
            return ORJSONResponse(
                status_code=status_code if status_code is not None else HTTPStatus.OK,
                content=jsonable_encoder(content),
            )
        else:
            return Response(
                status_code=status_code
                if status_code is not None
                else HTTPStatus.NO_CONTENT
            )

    # This is where we handle status codes via exceptions as raised by the impl methods
    except HTTPException as e:
        logger.debug(
            "Request failed",
            code=e.status_code,
            content=e.detail,
            traceback=traceback.print_exception(type(e), e, e.__traceback__),
        )
        return JSONResponse(status_code=e.status_code, content=e.detail)
    except Exception as e:
        logger.error(e)
        traceback.print_exception(type(e), e, e.__traceback__)
        return JSONResponse(
            status_code=HTTPStatus.INTERNAL_SERVER_ERROR,
            content=f"Something went wrong: {e}",
        )
