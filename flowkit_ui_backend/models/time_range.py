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


class TimeRange(BaseModel):
    """

    TimeRange - a model defined in OpenAPI

        start_date: The start_date of this TimeRange [Optional].
        end_date: The end_date of this TimeRange [Optional].
        all_dates: The all_dates of this TimeRange [Optional].
        min_value: The min_value of this TimeRange [Optional].
        max_value: The max_value of this TimeRange [Optional].
    """

    start_date: Optional[str] = None
    end_date: Optional[str] = None
    all_dates: Optional[List[str]] = None
    min_value: Optional[int] = None
    max_value: Optional[int] = None

    class Config:
        extra = "allow"

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

    @validator("end_date")
    def end_date_min_length(cls, value):
        assert len(value) >= 4
        return value

    @validator("end_date")
    def end_date_max_length(cls, value):
        assert len(value) <= 19
        return value

    @validator("end_date")
    def end_date_pattern(cls, value):
        assert value is not None and re.match(
            r"^([1-2][0-9]{3})((-(0[1-9]|1[0-2])(-(0[1-9]|[1-2][0-9]|3[0-1]))?(T(([0-1][0-9]|2[0-3]):([0-5][0-9])(:([0-5][0-9]))?))?)|(w(0[1-9]|[1-4][0-9]|5[0-3])))?$",
            value,
        )
        return value


TimeRange.update_forward_refs()
