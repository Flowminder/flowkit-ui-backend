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

from flowkit_ui_backend.models.bin import Bin

# see https://github.com/OpenAPITools/openapi-generator/blob/master/modules/openapi-generator/src/main/resources/python-flask/model.mustache
# for how to validate enums


class Indicator(BaseModel):
    """

    Indicator - a model defined in OpenAPI

        indicator_id: The indicator_id of this Indicator.
        category_id: The category_id of this Indicator.
        order: The order of this Indicator [Optional].
        flowgeek_url: The flowgeek_url of this Indicator [Optional].
        label: The label of this Indicator [Optional].
        description: The description of this Indicator [Optional].
        method: The method of this Indicator [Optional].
        scale: The scale of this Indicator [Optional].
        decimals: The decimals of this Indicator [Optional].
        min_value: The min_value of this Indicator [Optional].
        max_value: The max_value of this Indicator [Optional].
        num_bins: The num_bins of this Indicator [Optional].
        bins: The bins of this Indicator [Optional].
        translation: The translation of this Indicator [Optional].
    """

    indicator_id: str
    category_id: str
    order: Optional[int] = None
    flowgeek_url: Optional[str] = None
    label: Optional[str] = None
    description: Optional[str] = None
    method: Optional[str] = None
    scale: Optional[str] = None
    decimals: Optional[int] = None
    min_value: Optional[float] = None
    max_value: Optional[float] = None
    num_bins: Optional[float] = None
    bins: Optional[List[Bin]] = None
    translation: Optional[str] = None

    class Config:
        extra = "allow"

    @validator("indicator_id")
    def indicator_id_max_length(cls, value):
        assert len(value) <= 255
        return value

    @validator("category_id")
    def category_id_max_length(cls, value):
        assert len(value) <= 255
        return value


Indicator.update_forward_refs()
