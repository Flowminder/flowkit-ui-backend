# This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

# coding: utf-8

from __future__ import annotations
from datetime import date, datetime  # noqa: F401

import re  # noqa: F401
from typing import Any, Dict, List, Optional  # noqa: F401

from pydantic import AnyUrl, BaseModel, EmailStr, validator, BaseConfig  # noqa: F401

# required to make arbitrary datatypes work, see https://github.com/tiangolo/fastapi/issues/2382
BaseConfig.arbitrary_types_allowed = True


# see https://github.com/OpenAPITools/openapi-generator/blob/master/modules/openapi-generator/src/main/resources/python-flask/model.mustache
# for how to validate enums


class Heartbeat(BaseModel):
    """

    Heartbeat - a model defined in OpenAPI

        datetime: The datetime of this Heartbeat [Optional].
        docker_image: The docker_image of this Heartbeat [Optional].
        git_branch: The git_branch of this Heartbeat [Optional].
        git_commit: The git_commit of this Heartbeat [Optional].
        git_tag: The git_tag of this Heartbeat [Optional].
        python_package: The python_package of this Heartbeat [Optional].
        python_version: The python_version of this Heartbeat [Optional].
    """

    datetime: Optional[datetime] = None  # this breaks pydantic at least as far as 2.5.2
    docker_image: Optional[str] = None
    git_branch: Optional[str] = None
    git_commit: Optional[str] = None
    git_tag: Optional[str] = None
    python_package: Optional[str] = None
    python_version: Optional[str] = None

    class Config:
        extra = "allow"


Heartbeat.update_forward_refs()
