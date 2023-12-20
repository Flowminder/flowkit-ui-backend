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

from flowkit_ui_backend.db import db
from flowkit_ui_backend.util import gzip
from flowkit_ui_backend.models.extra_models import TokenModel  # noqa: F401
from flowkit_ui_backend.models.category import Category
from flowkit_ui_backend.models.config import Config
from flowkit_ui_backend.models.data_provider import DataProvider
from flowkit_ui_backend.models.dataset import Dataset
from flowkit_ui_backend.models.indicator import Indicator
from flowkit_ui_backend.models.scope_mapping import ScopeMapping
from flowkit_ui_backend.models.spatial_resolution import SpatialResolution
from flowkit_ui_backend.models.temporal_resolution import TemporalResolution
from flowkit_ui_backend.security_api import get_token_auth0
from flowkit_ui_backend.impl import maintenance_api_impl

router = APIRouter(route_class=gzip.GzipRoute)
logger = structlog.get_logger("flowkit_ui_backend.log")


@router.post(
    "/provision_db",
    responses={
        201: {"description": "Created: The resource was created successfully."},
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
    tags=["maintenance"],
    response_class=ORJSONResponse,
)
async def provision_db(
    token_auth0: TokenModel = Security(get_token_auth0, scopes=["admin"]),
    request: Request = None,
) -> None:
    """Provision the db."""

    try:
        logger.debug("Starting request")
        logger.debug("Provisioning database...")
        success = await db.provision_db(force=False, pool=request.app.state.pool)
        logger.debug(f"Provisioned database? {success}")
        logger.debug("Request ready")
        if success:
            status_code = 200
        else:
            status_code = 500
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
    "/force_provision_db",
    responses={
        201: {"description": "Created: The resource was created successfully."},
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
    tags=["maintenance"],
    response_class=ORJSONResponse,
)
async def force_provision_db(
    token_auth0: TokenModel = Security(get_token_auth0, scopes=["admin"]),
    request: Request = None,
) -> None:
    """Provision the db."""

    try:
        logger.debug("Starting request")
        logger.debug("Forcibly provisioning database...")
        success = await db.provision_db(force=True, pool=request.app.state.pool)
        logger.debug(f"Provisioned database? {success}")
        logger.debug("Request ready")
        if success:
            status_code = 200
        else:
            status_code = 500
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
    "/scope_mapping",
    responses={
        201: {"description": "Created: The resource was created successfully."},
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
    tags=["maintenance"],
    response_class=ORJSONResponse,
)
async def add_scope_mapping(
    scope_mapping: ScopeMapping = Body(
        None,
        description="A mapping between scopes and metadata IDs to signify what a scope gives access to",
    ),
    token_auth0: TokenModel = Security(get_token_auth0, scopes=["write:data"]),
    request: Request = None,
) -> None:
    """Add a scope mapping."""

    if not hasattr(maintenance_api_impl, "add_scope_mapping") or not callable(
        getattr(maintenance_api_impl, "add_scope_mapping")
    ):
        raise NotImplementedError(
            "The /add_scope_mapping endpoint is not yet implemented"
        )

    try:
        logger.debug("Starting request")
        impl_result = await maintenance_api_impl.add_scope_mapping(
            scope_mapping, pool=request.app.state.pool, token_model=token_auth0
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
    "/categories",
    responses={
        201: {
            "model": Category,
            "description": "Created: The resource has been added and is returned in the content part of this response.",
        },
        303: {
            "description": "See other: The resource already exists and is returned in the response."
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
    tags=["maintenance"],
    response_class=ORJSONResponse,
)
async def create_category(
    category: Category = Body(None, description="The category to add"),
    token_auth0: TokenModel = Security(get_token_auth0, scopes=["admin"]),
    request: Request = None,
) -> Category:
    """Adds a new category"""

    if not hasattr(maintenance_api_impl, "create_category") or not callable(
        getattr(maintenance_api_impl, "create_category")
    ):
        raise NotImplementedError(
            "The /create_category endpoint is not yet implemented"
        )

    try:
        logger.debug("Starting request")
        impl_result = await maintenance_api_impl.create_category(
            category, pool=request.app.state.pool, token_model=token_auth0
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
    "/data_providers",
    responses={
        201: {
            "model": DataProvider,
            "description": "Created: The resource has been added and is returned in the content part of this response.",
        },
        303: {
            "description": "See other: The resource already exists and is returned in the response."
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
    tags=["maintenance"],
    response_class=ORJSONResponse,
)
async def create_data_provider(
    data_provider: DataProvider = Body(None, description="The data provider to add"),
    token_auth0: TokenModel = Security(get_token_auth0, scopes=["admin"]),
    request: Request = None,
) -> DataProvider:
    """Adds a new data provider"""

    if not hasattr(maintenance_api_impl, "create_data_provider") or not callable(
        getattr(maintenance_api_impl, "create_data_provider")
    ):
        raise NotImplementedError(
            "The /create_data_provider endpoint is not yet implemented"
        )

    try:
        logger.debug("Starting request")
        impl_result = await maintenance_api_impl.create_data_provider(
            data_provider, pool=request.app.state.pool, token_model=token_auth0
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
    "/data",
    responses={
        201: {"description": "Created: The resource was created successfully."},
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
    tags=["maintenance"],
    response_class=ORJSONResponse,
)
async def create_dataset(
    dataset: Dataset = Body(
        None,
        description="A combination of data and metadata, representing a new dataset to be added",
    ),
    token_auth0: TokenModel = Security(get_token_auth0, scopes=["write:data"]),
    request: Request = None,
) -> None:
    """Add data and metadata to the database."""

    if not hasattr(maintenance_api_impl, "create_dataset") or not callable(
        getattr(maintenance_api_impl, "create_dataset")
    ):
        raise NotImplementedError("The /create_dataset endpoint is not yet implemented")

    try:
        logger.debug("Starting request")
        impl_result = await maintenance_api_impl.create_dataset(
            dataset, pool=request.app.state.pool, token_model=token_auth0
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
    "/indicators",
    responses={
        201: {
            "model": Indicator,
            "description": "Created: The resource has been added and is returned in the content part of this response.",
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
    tags=["maintenance"],
    response_class=ORJSONResponse,
)
async def create_indicator(
    indicator: Indicator = Body(None, description="The indicator to add"),
    token_auth0: TokenModel = Security(get_token_auth0, scopes=["admin"]),
    request: Request = None,
) -> Indicator:
    """Adds a new indicator"""

    if not hasattr(maintenance_api_impl, "create_indicator") or not callable(
        getattr(maintenance_api_impl, "create_indicator")
    ):
        raise NotImplementedError(
            "The /create_indicator endpoint is not yet implemented"
        )

    try:
        logger.debug("Starting request")
        impl_result = await maintenance_api_impl.create_indicator(
            indicator, pool=request.app.state.pool, token_model=token_auth0
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
    "/spatial_resolutions",
    responses={
        201: {
            "model": SpatialResolution,
            "description": "Created: The resource has been added and is returned in the content part of this response.",
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
    tags=["maintenance"],
    response_class=ORJSONResponse,
)
async def create_spatial_resolution(
    spatial_resolution: SpatialResolution = Body(
        None, description="The spatial resolution to add"
    ),
    token_auth0: TokenModel = Security(get_token_auth0, scopes=["admin"]),
    request: Request = None,
) -> SpatialResolution:
    """Adds a new spatial resolution"""

    if not hasattr(maintenance_api_impl, "create_spatial_resolution") or not callable(
        getattr(maintenance_api_impl, "create_spatial_resolution")
    ):
        raise NotImplementedError(
            "The /create_spatial_resolution endpoint is not yet implemented"
        )

    try:
        logger.debug("Starting request")
        impl_result = await maintenance_api_impl.create_spatial_resolution(
            spatial_resolution, pool=request.app.state.pool, token_model=token_auth0
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
    "/temporal_resolutions",
    responses={
        201: {
            "model": TemporalResolution,
            "description": "Created: The resource has been added and is returned in the content part of this response.",
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
    tags=["maintenance"],
    response_class=ORJSONResponse,
)
async def create_temporal_resolution(
    temporal_resolution: TemporalResolution = Body(
        None, description="The temporal resolution to add"
    ),
    token_auth0: TokenModel = Security(get_token_auth0, scopes=["admin"]),
    request: Request = None,
) -> TemporalResolution:
    """Adds a new temporal resolution"""

    if not hasattr(maintenance_api_impl, "create_temporal_resolution") or not callable(
        getattr(maintenance_api_impl, "create_temporal_resolution")
    ):
        raise NotImplementedError(
            "The /create_temporal_resolution endpoint is not yet implemented"
        )

    try:
        logger.debug("Starting request")
        impl_result = await maintenance_api_impl.create_temporal_resolution(
            temporal_resolution, pool=request.app.state.pool, token_model=token_auth0
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


@router.delete(
    "/categories/{category_id}",
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
    tags=["maintenance"],
    response_class=ORJSONResponse,
)
async def delete_category(
    category_id: str = Path(None, description="The category ID", max_length=255),
    token_auth0: TokenModel = Security(get_token_auth0, scopes=["admin"]),
    request: Request = None,
) -> None:
    """Deletes a single category"""

    if not hasattr(maintenance_api_impl, "delete_category") or not callable(
        getattr(maintenance_api_impl, "delete_category")
    ):
        raise NotImplementedError(
            "The /delete_category endpoint is not yet implemented"
        )

    try:
        logger.debug("Starting request")
        impl_result = await maintenance_api_impl.delete_category(
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


@router.delete(
    "/data_providers/{dpid}",
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
    tags=["maintenance"],
    response_class=ORJSONResponse,
)
async def delete_data_provider(
    dpid: int = Path(None, description="The data provider ID"),
    token_auth0: TokenModel = Security(get_token_auth0, scopes=["admin"]),
    request: Request = None,
) -> None:
    """Deletes a data provider"""

    if not hasattr(maintenance_api_impl, "delete_data_provider") or not callable(
        getattr(maintenance_api_impl, "delete_data_provider")
    ):
        raise NotImplementedError(
            "The /delete_data_provider endpoint is not yet implemented"
        )

    try:
        logger.debug("Starting request")
        impl_result = await maintenance_api_impl.delete_data_provider(
            dpid, pool=request.app.state.pool, token_model=token_auth0
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


@router.delete(
    "/data",
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
    tags=["maintenance"],
    response_class=ORJSONResponse,
)
async def delete_dataset(
    dataset: Dataset = Body(
        None,
        description="A combination of data and metadata, representing a new dataset to be added",
    ),
    token_auth0: TokenModel = Security(get_token_auth0, scopes=["write:data"]),
    request: Request = None,
) -> None:
    """Delete data and metadata from the database."""

    if not hasattr(maintenance_api_impl, "delete_dataset") or not callable(
        getattr(maintenance_api_impl, "delete_dataset")
    ):
        raise NotImplementedError("The /delete_dataset endpoint is not yet implemented")

    try:
        logger.debug("Starting request")
        impl_result = await maintenance_api_impl.delete_dataset(
            dataset, pool=request.app.state.pool, token_model=token_auth0
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


@router.delete(
    "/indicators/{indicator_id}",
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
    tags=["maintenance"],
    response_class=ORJSONResponse,
)
async def delete_indicator(
    indicator_id: str = Path(None, description="The indicator ID", max_length=255),
    token_auth0: TokenModel = Security(get_token_auth0, scopes=["admin"]),
    request: Request = None,
) -> None:
    """Deletes a single indicator"""

    if not hasattr(maintenance_api_impl, "delete_indicator") or not callable(
        getattr(maintenance_api_impl, "delete_indicator")
    ):
        raise NotImplementedError(
            "The /delete_indicator endpoint is not yet implemented"
        )

    try:
        logger.debug("Starting request")
        impl_result = await maintenance_api_impl.delete_indicator(
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


@router.delete(
    "/scope_mapping",
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
    tags=["maintenance"],
    response_class=ORJSONResponse,
)
async def delete_scope_mapping(
    scope_mapping: ScopeMapping = Body(
        None,
        description="A mapping between scopes and metadata IDs to signify what a scope gives access to",
    ),
    token_auth0: TokenModel = Security(get_token_auth0, scopes=["write:data"]),
    request: Request = None,
) -> None:
    """Delete a scope mapping."""

    if not hasattr(maintenance_api_impl, "delete_scope_mapping") or not callable(
        getattr(maintenance_api_impl, "delete_scope_mapping")
    ):
        raise NotImplementedError(
            "The /delete_scope_mapping endpoint is not yet implemented"
        )

    try:
        logger.debug("Starting request")
        impl_result = await maintenance_api_impl.delete_scope_mapping(
            scope_mapping, pool=request.app.state.pool, token_model=token_auth0
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


@router.delete(
    "/setup",
    responses={
        204: {"description": "OK: The request was successful."},
        400: {
            "description": "Bad Request: The request is malformed, incomplete or otherwise invalid."
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
    tags=["maintenance"],
    response_class=ORJSONResponse,
)
async def delete_setup(
    token_auth0: TokenModel = Security(get_token_auth0, scopes=["admin"]),
    request: Request = None,
) -> None:
    """Delete all existing data."""

    if not hasattr(maintenance_api_impl, "delete_setup") or not callable(
        getattr(maintenance_api_impl, "delete_setup")
    ):
        raise NotImplementedError("The /delete_setup endpoint is not yet implemented")

    try:
        logger.debug("Starting request")
        impl_result = await maintenance_api_impl.delete_setup(
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


@router.delete(
    "/spatial_resolutions/{srid}",
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
    tags=["maintenance"],
    response_class=ORJSONResponse,
)
async def delete_spatial_resolution(
    srid: int = Path(None, description="The spatial resolution ID", ge=1),
    token_auth0: TokenModel = Security(get_token_auth0, scopes=["admin"]),
    request: Request = None,
) -> None:
    """Deletes a spatial resolution"""

    if not hasattr(maintenance_api_impl, "delete_spatial_resolution") or not callable(
        getattr(maintenance_api_impl, "delete_spatial_resolution")
    ):
        raise NotImplementedError(
            "The /delete_spatial_resolution endpoint is not yet implemented"
        )

    try:
        logger.debug("Starting request")
        impl_result = await maintenance_api_impl.delete_spatial_resolution(
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


@router.delete(
    "/temporal_resolutions/{trid}",
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
    tags=["maintenance"],
    response_class=ORJSONResponse,
)
async def delete_temporal_resolution(
    trid: int = Path(None, description="The temporal resolution ID", ge=1),
    token_auth0: TokenModel = Security(get_token_auth0, scopes=["admin"]),
    request: Request = None,
) -> None:
    """Deletes a temporal resolution"""

    if not hasattr(maintenance_api_impl, "delete_temporal_resolution") or not callable(
        getattr(maintenance_api_impl, "delete_temporal_resolution")
    ):
        raise NotImplementedError(
            "The /delete_temporal_resolution endpoint is not yet implemented"
        )

    try:
        logger.debug("Starting request")
        impl_result = await maintenance_api_impl.delete_temporal_resolution(
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


@router.post(
    "/setup",
    responses={
        204: {"description": "OK: The request was successful."},
        400: {
            "description": "Bad Request: The request is malformed, incomplete or otherwise invalid."
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
    tags=["maintenance"],
    response_class=ORJSONResponse,
)
async def replace_setup(
    config: Config = Body(None, description="A server configuration"),
    token_auth0: TokenModel = Security(get_token_auth0, scopes=["admin"]),
    request: Request = None,
) -> None:
    """Set up the data storage using the data submitted in this request. Delete all existing data."""

    if not hasattr(maintenance_api_impl, "replace_setup") or not callable(
        getattr(maintenance_api_impl, "replace_setup")
    ):
        raise NotImplementedError("The /replace_setup endpoint is not yet implemented")

    try:
        logger.debug("Starting request")
        impl_result = await maintenance_api_impl.replace_setup(
            config, pool=request.app.state.pool, token_model=token_auth0
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
    "/categories/{category_id}",
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
    tags=["maintenance"],
    response_class=ORJSONResponse,
)
async def update_category(
    category_id: str = Path(None, description="The category ID", max_length=255),
    category: Category = Body(None, description="The new resource"),
    token_auth0: TokenModel = Security(get_token_auth0, scopes=["admin"]),
    request: Request = None,
) -> None:
    """Updates a category"""

    if not hasattr(maintenance_api_impl, "update_category") or not callable(
        getattr(maintenance_api_impl, "update_category")
    ):
        raise NotImplementedError(
            "The /update_category endpoint is not yet implemented"
        )

    try:
        logger.debug("Starting request")
        impl_result = await maintenance_api_impl.update_category(
            category_id, category, pool=request.app.state.pool, token_model=token_auth0
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
    "/data_providers/{dpid}",
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
    tags=["maintenance"],
    response_class=ORJSONResponse,
)
async def update_data_provider(
    dpid: int = Path(None, description="The data provider ID"),
    data_provider: DataProvider = Body(None, description="The new resource"),
    token_auth0: TokenModel = Security(get_token_auth0, scopes=["write:data"]),
    request: Request = None,
) -> None:
    """Updates a data provider"""

    if not hasattr(maintenance_api_impl, "update_data_provider") or not callable(
        getattr(maintenance_api_impl, "update_data_provider")
    ):
        raise NotImplementedError(
            "The /update_data_provider endpoint is not yet implemented"
        )

    try:
        logger.debug("Starting request")
        impl_result = await maintenance_api_impl.update_data_provider(
            dpid, data_provider, pool=request.app.state.pool, token_model=token_auth0
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
    "/data",
    responses={
        201: {"description": "Created: The resource was created successfully."},
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
    tags=["maintenance"],
    response_class=ORJSONResponse,
)
async def update_dataset(
    dataset: Dataset = Body(None, description="The new resource"),
    token_auth0: TokenModel = Security(get_token_auth0, scopes=["write:data"]),
    request: Request = None,
) -> None:
    """Add data and metadata to the database and overwrite if it exists."""

    if not hasattr(maintenance_api_impl, "update_dataset") or not callable(
        getattr(maintenance_api_impl, "update_dataset")
    ):
        raise NotImplementedError("The /update_dataset endpoint is not yet implemented")

    try:
        logger.debug("Starting request")
        impl_result = await maintenance_api_impl.update_dataset(
            dataset, pool=request.app.state.pool, token_model=token_auth0
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
    "/indicators/{indicator_id}",
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
    tags=["maintenance"],
    response_class=ORJSONResponse,
)
async def update_indicator(
    indicator_id: str = Path(None, description="The indicator ID", max_length=255),
    indicator: Indicator = Body(None, description="The new resource"),
    token_auth0: TokenModel = Security(get_token_auth0, scopes=["admin"]),
    request: Request = None,
) -> None:
    """Updates an indicator"""

    if not hasattr(maintenance_api_impl, "update_indicator") or not callable(
        getattr(maintenance_api_impl, "update_indicator")
    ):
        raise NotImplementedError(
            "The /update_indicator endpoint is not yet implemented"
        )

    try:
        logger.debug("Starting request")
        impl_result = await maintenance_api_impl.update_indicator(
            indicator_id,
            indicator,
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


@router.patch(
    "/setup",
    responses={
        204: {"description": "OK: The request was successful."},
        400: {
            "description": "Bad Request: The request is malformed, incomplete or otherwise invalid."
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
    tags=["maintenance"],
    response_class=ORJSONResponse,
)
async def update_setup(
    config: Config = Body(None, description="A server configuration"),
    token_auth0: TokenModel = Security(get_token_auth0, scopes=["admin"]),
    request: Request = None,
) -> None:
    """Set up the data storage using the data submitted in this request. Update existing data where it exists."""

    if not hasattr(maintenance_api_impl, "update_setup") or not callable(
        getattr(maintenance_api_impl, "update_setup")
    ):
        raise NotImplementedError("The /update_setup endpoint is not yet implemented")

    try:
        logger.debug("Starting request")
        impl_result = await maintenance_api_impl.update_setup(
            config, pool=request.app.state.pool, token_model=token_auth0
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
    "/spatial_resolutions/{srid}",
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
    tags=["maintenance"],
    response_class=ORJSONResponse,
)
async def update_spatial_resolution(
    srid: int = Path(None, description="The spatial resolution ID", ge=1),
    spatial_resolution: SpatialResolution = Body(None, description="The new resource"),
    token_auth0: TokenModel = Security(get_token_auth0, scopes=["admin"]),
    request: Request = None,
) -> None:
    """Updates a spatial resolution"""

    if not hasattr(maintenance_api_impl, "update_spatial_resolution") or not callable(
        getattr(maintenance_api_impl, "update_spatial_resolution")
    ):
        raise NotImplementedError(
            "The /update_spatial_resolution endpoint is not yet implemented"
        )

    try:
        logger.debug("Starting request")
        impl_result = await maintenance_api_impl.update_spatial_resolution(
            srid,
            spatial_resolution,
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


@router.patch(
    "/temporal_resolutions/{trid}",
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
    tags=["maintenance"],
    response_class=ORJSONResponse,
)
async def update_temporal_resolution(
    trid: int = Path(None, description="The temporal resolution ID", ge=1),
    temporal_resolution: TemporalResolution = Body(
        None, description="The new resource"
    ),
    token_auth0: TokenModel = Security(get_token_auth0, scopes=["admin"]),
    request: Request = None,
) -> None:
    """Updates a temporal resolution"""

    if not hasattr(maintenance_api_impl, "update_temporal_resolution") or not callable(
        getattr(maintenance_api_impl, "update_temporal_resolution")
    ):
        raise NotImplementedError(
            "The /update_temporal_resolution endpoint is not yet implemented"
        )

    try:
        logger.debug("Starting request")
        impl_result = await maintenance_api_impl.update_temporal_resolution(
            trid,
            temporal_resolution,
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
