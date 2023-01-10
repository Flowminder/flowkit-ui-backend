# This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

import structlog
import datetime
import os
import platform
from http import HTTPStatus
from fastapi import HTTPException
from aiomysql import Pool
from dotenv import load_dotenv
from flowkit_ui_backend.models.config import Config
from flowkit_ui_backend.models.language import Language
from flowkit_ui_backend.models.data_provider import DataProvider
from flowkit_ui_backend.models.data_providers import DataProviders
from flowkit_ui_backend.models.heartbeat import Heartbeat
from flowkit_ui_backend.impl.util import db


load_dotenv()

logger = structlog.get_logger("flowkit_ui_backend.log")


async def get_setup(pool: Pool = None) -> Config:
    languages = await db.select_data(base_model=Language, pool=pool)
    data_providers = await db.select_data(base_model=DataProvider, pool=pool)

    # not returning categories etc here as that would require extra permissions this endpoint does not have
    config = Config(
        languages=languages,
        data_providers=data_providers,
        categories=[],
        indicators=[],
        spatial_resolutions=[],
        temporal_resolutions=[],
    )
    return config


async def list_data_providers(pool: Pool = None) -> DataProviders:
    data_providers = await db.select_data(base_model=DataProvider, pool=pool)
    return DataProviders(data_providers=data_providers)


async def get_data_provider(dpid: int, pool: Pool = None) -> DataProvider:
    data_providers = await db.select_data(
        base_model=DataProvider, id_key="dpid", ids=[dpid], pool=pool
    )
    if len(data_providers) == 0:
        raise HTTPException(status_code=HTTPStatus.NOT_FOUND, detail="No data providers found")
    return data_providers[0]


async def heartbeat(pool: Pool = None) -> Heartbeat:
    logger.info("Request received, sending heartbeat...")
    heartbeat = Heartbeat(
        api_version=os.getenv("API_VERSION"),
        api_version_url_appendix=os.getenv("API_VERSION_URL_APPENDIX"),
        datetime=f"{datetime.datetime.utcnow().isoformat()}Z",
        docker_image=os.getenv("IMAGE_NAME"),
        git_branch=os.getenv("GIT_BRANCH"),
        git_commit=os.getenv("GIT_COMMIT"),
        git_tag=os.getenv("GIT_TAG") if os.getenv("GIT_TAG") != "" else None,
        python_package=os.getenv("APP_NAME"),
        python_version=platform.python_version(),
    )
    return heartbeat
