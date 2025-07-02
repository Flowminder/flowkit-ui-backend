# This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

# coding: utf-8

from __future__ import annotations
from datetime import date, datetime  # noqa: F401

import re  # noqa: F401
from typing import Any, Dict, List, Optional  # noqa: F401

from pydantic.v1 import AnyUrl, BaseModel, EmailStr, validator, BaseConfig  # noqa: F401

# required to make arbitrary datatypes work, see https://github.com/tiangolo/fastapi/issues/2382
BaseConfig.arbitrary_types_allowed = True


# see https://github.com/OpenAPITools/openapi-generator/blob/master/modules/openapi-generator/src/main/resources/python-flask/model.mustache
# for how to validate enums


class QueryParameters(BaseModel):
    """

    QueryParameters - a model defined in OpenAPI

        category_id: The category_id of this QueryParameters.
        indicator_id: The indicator_id of this QueryParameters.
        srid: The srid of this QueryParameters.
        trid: The trid of this QueryParameters.
        start_date: The start_date of this QueryParameters.
        duration: The duration of this QueryParameters.
        mdids_only: The mdids_only of this QueryParameters [Optional].
    """

    category_id: str
    indicator_id: str
    srid: int
    trid: int
    start_date: str
    duration: int
    mdids_only: Optional[bool] = None

    class Config:
        extra = "allow"

    @validator("category_id")
    def category_id_max_length(cls, value):
        assert len(value) <= 255
        return value

    @validator("indicator_id")
    def indicator_id_max_length(cls, value):
        assert len(value) <= 255
        return value

    @validator("srid")
    def srid_min(cls, value):
        assert value >= 1
        return value

    @validator("trid")
    def trid_min(cls, value):
        assert value >= 1
        return value

    @validator("start_date")
    def start_date_min_length(cls, value):
        assert len(value) >= 4
        return value

    @validator("start_date")
    def start_date_max_length(cls, value):
        assert len(value) <= 19
        return value

    @validator("start_date")
    def start_date_pattern(cls, value):
        assert value is not None and re.match(
            r"^([1-2][0-9]{3})((-(0[1-9]|1[0-2])(-(0[1-9]|[1-2][0-9]|3[0-1]))?(T(([0-1][0-9]|2[0-3]):([0-5][0-9])(:([0-5][0-9]))?))?)|(w(0[1-9]|[1-4][0-9]|5[0-3])))?$",
            value,
        )
        return value

    @validator("duration")
    def duration_min(cls, value):
        assert value >= 1
        return value


QueryParameters.update_forward_refs()
