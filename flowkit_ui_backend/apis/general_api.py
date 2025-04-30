# This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

# coding: utf-8

import structlog
import traceback
from http import HTTPStatus
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
from flowkit_ui_backend.models.config import Config
from flowkit_ui_backend.models.data_providers import DataProviders
from flowkit_ui_backend.models.heartbeat import Heartbeat

from flowkit_ui_backend.impl import general_api_impl
from flowkit_ui_backend.util.config import SettingsDep

router = APIRouter(route_class=gzip.GzipRoute)
logger = structlog.get_logger("flowkit_ui_backend.log")


@router.get(
    "/setup",
    responses={
        200: {
            "model": Config,
            "description": "OK: The results for this request were retrieved successfully.",
        },
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
    tags=["general"],
    response_class=ORJSONResponse,
)
async def get_setup(request: Request = None) -> Config:
    """Get the current config for this flowkit-ui-backend server."""

    if not hasattr(general_api_impl, "get_setup") or not callable(
        getattr(general_api_impl, "get_setup")
    ):
        raise NotImplementedError("The /get_setup endpoint is not yet implemented")

    try:
        logger.debug("Starting request")
        impl_result = await general_api_impl.get_setup(pool=request.app.state.pool)
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
                status_code=(
                    status_code if status_code is not None else HTTPStatus.NO_CONTENT
                )
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
    "/heartbeat",
    responses={
        200: {
            "model": Heartbeat,
            "description": "OK: The results for this request were retrieved successfully.",
        },
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
    tags=["general"],
    response_class=ORJSONResponse,
)
async def heartbeat(request: Request, settings: SettingsDep) -> Heartbeat:
    """Checks whether the API is up and running"""

    if not hasattr(general_api_impl, "heartbeat") or not callable(
        getattr(general_api_impl, "heartbeat")
    ):
        raise NotImplementedError("The /heartbeat endpoint is not yet implemented")

    try:
        logger.debug("Starting request")
        impl_result = await general_api_impl.heartbeat(
            pool=request.app.state.pool, settings=settings
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
                status_code=(
                    status_code if status_code is not None else HTTPStatus.NO_CONTENT
                )
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
    "/data_providers",
    responses={
        200: {
            "model": DataProviders,
            "description": "OK: The results for this request were retrieved successfully.",
        },
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
    tags=["general"],
    response_class=ORJSONResponse,
)
async def list_data_providers(request: Request = None) -> DataProviders:
    """Gets a list of all data providers configured for this flowkit-ui-backend instance"""

    if not hasattr(general_api_impl, "list_data_providers") or not callable(
        getattr(general_api_impl, "list_data_providers")
    ):
        raise NotImplementedError(
            "The /list_data_providers endpoint is not yet implemented"
        )

    try:
        logger.debug("Starting request")
        impl_result = await general_api_impl.list_data_providers(
            pool=request.app.state.pool
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
                status_code=(
                    status_code if status_code is not None else HTTPStatus.NO_CONTENT
                )
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
