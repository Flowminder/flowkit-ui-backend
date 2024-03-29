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


class TemporalResolution(BaseModel):
    """

    TemporalResolution - a model defined in OpenAPI

        trid: The trid of this TemporalResolution [Optional].
        label: The label of this TemporalResolution.
        index: The index of this TemporalResolution.
        relativedelta_unit: The relativedelta_unit of this TemporalResolution.
        relativedelta_num: The relativedelta_num of this TemporalResolution.
        date_format: The date_format of this TemporalResolution [Optional].
        default_selected: The default_selected of this TemporalResolution.
        description: The description of this TemporalResolution [Optional].
        translation: The translation of this TemporalResolution [Optional].
    """

    trid: Optional[int] = None
    label: str
    index: int
    relativedelta_unit: str
    relativedelta_num: int
    date_format: Optional[str] = None
    default_selected: int
    description: Optional[str] = None
    translation: Optional[str] = None

    class Config:
        extra = "allow"

    @validator("index")
    def index_min(cls, value):
        assert value >= 0
        return value

    @validator("relativedelta_num")
    def relativedelta_num_min(cls, value):
        assert value >= 1
        return value

    @validator("default_selected")
    def default_selected_min(cls, value):
        assert value >= 1
        return value


TemporalResolution.update_forward_refs()
