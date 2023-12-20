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
from flowkit_ui_backend.models.categories import Categories
from flowkit_ui_backend.models.category import Category
from flowkit_ui_backend.models.indicator import Indicator
from flowkit_ui_backend.models.indicators import Indicators
from flowkit_ui_backend.models.query_parameters import QueryParameters
from flowkit_ui_backend.models.query_result import QueryResult
from flowkit_ui_backend.models.spatial_resolution import SpatialResolution
from flowkit_ui_backend.models.spatial_resolutions import SpatialResolutions
from flowkit_ui_backend.models.temporal_resolution import TemporalResolution
from flowkit_ui_backend.models.temporal_resolutions import TemporalResolutions
from flowkit_ui_backend.models.time_range import TimeRange
from flowkit_ui_backend.security_api import get_token_auth0
from flowkit_ui_backend.impl import data_api_impl

router = APIRouter(route_class=gzip.GzipRoute)
logger = structlog.get_logger("flowkit_ui_backend.log")


@router.get(
    "/categories/{category_id}",
    responses={
        200: {
            "model": Category,
            "description": "OK: The results for this request were retrieved successfully.",
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
    tags=["data"],
    response_class=ORJSONResponse,
)
async def get_category(
    category_id: str = Path(None, description="The category ID", max_length=255),
    token_auth0: TokenModel = Security(get_token_auth0, scopes=["read:free_data"]),
    request: Request = None,
) -> Category:
    """Gets a single category"""

    if not hasattr(data_api_impl, "get_category") or not callable(
        getattr(data_api_impl, "get_category")
    ):
        raise NotImplementedError("The /get_category endpoint is not yet implemented")

    try:
        logger.debug("Starting request")
        impl_result = await data_api_impl.get_category(
            category_id, pool=request.app.state.pool, token_model=token_auth0
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
    "/indicators/{indicator_id}",
    responses={
        200: {
            "model": Indicator,
            "description": "OK: The results for this request were retrieved successfully.",
        },
        401: {
            "description": "Unauthorized: The user does not have the permissions to access this resource."
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
    tags=["data"],
    response_class=ORJSONResponse,
)
async def get_indicator(
    indicator_id: str = Path(None, description="The indicator ID", max_length=255),
    token_auth0: TokenModel = Security(get_token_auth0, scopes=["read:free_data"]),
    request: Request = None,
) -> Indicator:
    """Gets a single indicator"""

    if not hasattr(data_api_impl, "get_indicator") or not callable(
        getattr(data_api_impl, "get_indicator")
    ):
        raise NotImplementedError("The /get_indicator endpoint is not yet implemented")

    try:
        logger.debug("Starting request")
        impl_result = await data_api_impl.get_indicator(
            indicator_id, pool=request.app.state.pool, token_model=token_auth0
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
    "/indicators_for_category/{category_id}",
    responses={
        200: {
            "model": Indicators,
            "description": "OK: The results for this request were retrieved successfully.",
        },
        401: {
            "description": "Unauthorized: The user does not have the permissions to access this resource."
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
    tags=["data"],
    response_class=ORJSONResponse,
)
async def get_indicators_for_category(
    category_id: str = Path(None, description="The category ID", max_length=255),
    token_auth0: TokenModel = Security(get_token_auth0, scopes=["read:free_data"]),
    request: Request = None,
) -> Indicators:
    """Gets all available indicators for the given category"""

    if not hasattr(data_api_impl, "get_indicators_for_category") or not callable(
        getattr(data_api_impl, "get_indicators_for_category")
    ):
        raise NotImplementedError(
            "The /get_indicators_for_category endpoint is not yet implemented"
        )

    try:
        logger.debug("Starting request")
        impl_result = await data_api_impl.get_indicators_for_category(
            category_id, pool=request.app.state.pool, token_model=token_auth0
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
    "/spatial_resolutions/{srid}",
    responses={
        200: {
            "model": SpatialResolution,
            "description": "OK: The resource exists and is returned in the content part of this response.",
        },
        401: {
            "description": "Unauthorized: The user does not have the permissions to access this resource."
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
    tags=["data"],
    response_class=ORJSONResponse,
)
async def get_spatial_resolution(
    srid: int = Path(None, description="The spatial resolution ID", ge=1),
    token_auth0: TokenModel = Security(get_token_auth0, scopes=["read:free_data"]),
    request: Request = None,
) -> SpatialResolution:
    """Gets a single spatial resolution"""

    if not hasattr(data_api_impl, "get_spatial_resolution") or not callable(
        getattr(data_api_impl, "get_spatial_resolution")
    ):
        raise NotImplementedError(
            "The /get_spatial_resolution endpoint is not yet implemented"
        )

    try:
        logger.debug("Starting request")
        impl_result = await data_api_impl.get_spatial_resolution(
            srid, pool=request.app.state.pool, token_model=token_auth0
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
    "/spatial_resolutions_for_category/{category_id}",
    responses={
        200: {
            "model": SpatialResolutions,
            "description": "OK: The results for this request were retrieved successfully.",
        },
        401: {
            "description": "Unauthorized: The user does not have the permissions to access this resource."
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
    tags=["data"],
    response_class=ORJSONResponse,
)
async def get_spatial_resolutions_for_category(
    category_id: str = Path(None, description="The category ID", max_length=255),
    token_auth0: TokenModel = Security(get_token_auth0, scopes=["read:free_data"]),
    request: Request = None,
) -> SpatialResolutions:
    """Gets all available spatial resolutions for a category but without the boundaries"""

    if not hasattr(
        data_api_impl, "get_spatial_resolutions_for_category"
    ) or not callable(getattr(data_api_impl, "get_spatial_resolutions_for_category")):
        raise NotImplementedError(
            "The /get_spatial_resolutions_for_category endpoint is not yet implemented"
        )

    try:
        logger.debug("Starting request")
        impl_result = await data_api_impl.get_spatial_resolutions_for_category(
            category_id, pool=request.app.state.pool, token_model=token_auth0
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
    "/temporal_resolutions/{trid}",
    responses={
        200: {
            "model": TemporalResolution,
            "description": "OK: The resource exists and is returned in the content part of this response.",
        },
        401: {
            "description": "Unauthorized: The user does not have the permissions to access this resource."
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
    tags=["data"],
    response_class=ORJSONResponse,
)
async def get_temporal_resolution(
    trid: int = Path(None, description="The temporal resolution ID", ge=1),
    token_auth0: TokenModel = Security(get_token_auth0, scopes=["read:free_data"]),
    request: Request = None,
) -> TemporalResolution:
    """Gets a single temporal resolution"""

    if not hasattr(data_api_impl, "get_temporal_resolution") or not callable(
        getattr(data_api_impl, "get_temporal_resolution")
    ):
        raise NotImplementedError(
            "The /get_temporal_resolution endpoint is not yet implemented"
        )

    try:
        logger.debug("Starting request")
        impl_result = await data_api_impl.get_temporal_resolution(
            trid, pool=request.app.state.pool, token_model=token_auth0
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
    "/temporal_resolutions_for_category/{category_id}",
    responses={
        200: {
            "model": TemporalResolutions,
            "description": "OK: The results for this request were retrieved successfully.",
        },
        401: {
            "description": "Unauthorized: The user does not have the permissions to access this resource."
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
    tags=["data"],
    response_class=ORJSONResponse,
)
async def get_temporal_resolutions_for_category(
    category_id: str = Path(None, description="The category ID", max_length=255),
    token_auth0: TokenModel = Security(get_token_auth0, scopes=["read:free_data"]),
    request: Request = None,
) -> TemporalResolutions:
    """Gets all available temporal resolutions for this category"""

    if not hasattr(
        data_api_impl, "get_temporal_resolutions_for_category"
    ) or not callable(getattr(data_api_impl, "get_temporal_resolutions_for_category")):
        raise NotImplementedError(
            "The /get_temporal_resolutions_for_category endpoint is not yet implemented"
        )

    try:
        logger.debug("Starting request")
        impl_result = await data_api_impl.get_temporal_resolutions_for_category(
            category_id, pool=request.app.state.pool, token_model=token_auth0
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
    "/timerange/{category_id}/{indicator_id}/{srid}/{trid}",
    responses={
        200: {
            "model": TimeRange,
            "description": "OK: The request was valid and the result is returned in the content part of this response.",
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
    tags=["data"],
    response_class=ORJSONResponse,
)
async def get_time_range(
    category_id: str = Path(None, description="The category ID", max_length=255),
    indicator_id: str = Path(None, description="The indicator ID", max_length=255),
    srid: int = Path(None, description="The spatial resolution ID", ge=1),
    trid: int = Path(None, description="The temporal resolution ID", ge=1),
    token_auth0: TokenModel = Security(get_token_auth0, scopes=["read:free_data"]),
    request: Request = None,
) -> TimeRange:
    """Get the range of available temporal units for the given parameters"""

    if not hasattr(data_api_impl, "get_time_range") or not callable(
        getattr(data_api_impl, "get_time_range")
    ):
        raise NotImplementedError("The /get_time_range endpoint is not yet implemented")

    try:
        logger.debug("Starting request")
        impl_result = await data_api_impl.get_time_range(
            category_id,
            indicator_id,
            srid,
            trid,
            pool=request.app.state.pool,
            token_model=token_auth0,
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
    "/categories",
    responses={
        200: {
            "model": Categories,
            "description": "OK: The results for this request were retrieved successfully.",
        },
        401: {
            "description": "Unauthorized: The user does not have the permissions to access this resource."
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
    tags=["data"],
    response_class=ORJSONResponse,
)
async def list_categories(
    token_auth0: TokenModel = Security(get_token_auth0, scopes=["read:free_data"]),
    request: Request = None,
) -> Categories:
    """Gets all available categories currently ingested in this flowkit-ui-backend instance"""

    if not hasattr(data_api_impl, "list_categories") or not callable(
        getattr(data_api_impl, "list_categories")
    ):
        raise NotImplementedError(
            "The /list_categories endpoint is not yet implemented"
        )

    try:
        logger.debug("Starting request")
        impl_result = await data_api_impl.list_categories(
            pool=request.app.state.pool, token_model=token_auth0
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
    "/indicators",
    responses={
        200: {
            "model": Indicators,
            "description": "OK: The results for this request were retrieved successfully.",
        },
        401: {
            "description": "Unauthorized: The user does not have the permissions to access this resource."
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
    tags=["data"],
    response_class=ORJSONResponse,
)
async def list_indicators(
    token_auth0: TokenModel = Security(get_token_auth0, scopes=["read:free_data"]),
    request: Request = None,
) -> Indicators:
    """Gets all available indicators currently ingested in this flowkit-ui-backend instance"""

    if not hasattr(data_api_impl, "list_indicators") or not callable(
        getattr(data_api_impl, "list_indicators")
    ):
        raise NotImplementedError(
            "The /list_indicators endpoint is not yet implemented"
        )

    try:
        logger.debug("Starting request")
        impl_result = await data_api_impl.list_indicators(
            pool=request.app.state.pool, token_model=token_auth0
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
    "/spatial_resolutions",
    responses={
        200: {
            "model": SpatialResolutions,
            "description": "OK: The results for this request were retrieved successfully.",
        },
        401: {
            "description": "Unauthorized: The user does not have the permissions to access this resource."
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
    tags=["data"],
    response_class=ORJSONResponse,
)
async def list_spatial_resolutions(
    token_auth0: TokenModel = Security(get_token_auth0, scopes=["read:free_data"]),
    request: Request = None,
) -> SpatialResolutions:
    """Gets all available spatial resolutions currently ingested in this flowkit-ui-backend instance. This excludes the boundaries, which are typically quite large and should be retrieved individually."""

    if not hasattr(data_api_impl, "list_spatial_resolutions") or not callable(
        getattr(data_api_impl, "list_spatial_resolutions")
    ):
        raise NotImplementedError(
            "The /list_spatial_resolutions endpoint is not yet implemented"
        )

    try:
        logger.debug("Starting request")
        impl_result = await data_api_impl.list_spatial_resolutions(
            pool=request.app.state.pool, token_model=token_auth0
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
    "/temporal_resolutions",
    responses={
        200: {
            "model": TemporalResolutions,
            "description": "OK: The results for this request were retrieved successfully.",
        },
        401: {
            "description": "Unauthorized: The user does not have the permissions to access this resource."
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
    tags=["data"],
    response_class=ORJSONResponse,
)
async def list_temporal_resolutions(
    token_auth0: TokenModel = Security(get_token_auth0, scopes=["read:free_data"]),
    request: Request = None,
) -> TemporalResolutions:
    """Gets all available temporal resolutions currently ingested in this flowkit-ui-backend instance"""

    if not hasattr(data_api_impl, "list_temporal_resolutions") or not callable(
        getattr(data_api_impl, "list_temporal_resolutions")
    ):
        raise NotImplementedError(
            "The /list_temporal_resolutions endpoint is not yet implemented"
        )

    try:
        logger.debug("Starting request")
        impl_result = await data_api_impl.list_temporal_resolutions(
            pool=request.app.state.pool, token_model=token_auth0
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


@router.post(
    "/csv",
    responses={
        200: {
            "model": str,
            "description": "OK: The results for this request were retrieved successfully.",
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
    tags=["data"],
    response_class=ORJSONResponse,
)
async def run_csv_query(
    query_parameters: QueryParameters = Body(None, description="The query parameters"),
    token_auth0: TokenModel = Security(get_token_auth0, scopes=["read:free_data"]),
    request: Request = None,
) -> str:
    """Run a query to get data from the database, returned as CSV"""

    if not hasattr(data_api_impl, "run_csv_query") or not callable(
        getattr(data_api_impl, "run_csv_query")
    ):
        raise NotImplementedError("The /run_csv_query endpoint is not yet implemented")

    try:
        logger.debug("Starting request")
        impl_result = await data_api_impl.run_csv_query(
            query_parameters, pool=request.app.state.pool, token_model=token_auth0
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


@router.post(
    "/query",
    responses={
        200: {
            "model": QueryResult,
            "description": "OK: The data query was valid and the result is returned in the content part of this response.",
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
    tags=["data"],
    response_class=ORJSONResponse,
)
async def run_query(
    query_parameters: QueryParameters = Body(None, description="The query parameters"),
    token_auth0: TokenModel = Security(get_token_auth0, scopes=["read:free_data"]),
    request: Request = None,
) -> QueryResult:
    """Run a query to get data from the database"""

    if not hasattr(data_api_impl, "run_query") or not callable(
        getattr(data_api_impl, "run_query")
    ):
        raise NotImplementedError("The /run_query endpoint is not yet implemented")

    try:
        logger.debug("Starting request")
        impl_result = await data_api_impl.run_query(
            query_parameters, pool=request.app.state.pool, token_model=token_auth0
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
