# This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.
from functools import lru_cache
from typing import Optional, Annotated

from fastapi import Depends
from pydantic import BaseSettings, Field
from pydantic.networks import AnyHttpUrl
from pydantic.types import SecretStr

from flowkit_ui_backend.util.logging import LogLevel


class Settings(BaseSettings):
    """
    Config class using pydantic's settings management. By default, this will
    load the values from environment variables which are just the uppercased
    version of the name, so for example db_port_container takes the value of DB_PORT_CONTAINER.
    """

    db_port_container: int
    db_pw: SecretStr
    db_name: str = Field(
        "flowkit_ui_backend", const=True
    )  # This should really be configurable but is hardcoded in the schema at present
    db_user: str
    container_name_db: str
    flowkit_ui_url: AnyHttpUrl
    auth0_domain: str
    auth0_client_id: str
    auth0_client_secret: SecretStr
    auth0_audience: str
    api_version_url_appendix: str
    server_port_host: int
    image_name: str
    git_branch: str
    git_commit: str
    app_name: str
    secure_file_bucket: str
    dqs_bucket_path: str
    git_tag: Optional[str] = None
    dev_mode: int = 0
    log_level: LogLevel = LogLevel.WARNING
    jupyter_enabled: int = 0
    jupyter_port: Optional[int] = None
    daily_csv_pre_batch_chunk_size: int = 50


@lru_cache
def get_settings() -> Settings:
    return Settings()


SettingsDep = Annotated[Settings, Depends(get_settings)]
