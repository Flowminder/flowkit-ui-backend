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


class Category(BaseModel):
    """

    Category - a model defined in OpenAPI

        category_id: The category_id of this Category.
        type: The type of this Category.
        order: The order of this Category [Optional].
        flowgeek_url: The flowgeek_url of this Category [Optional].
        label: The label of this Category [Optional].
        description: The description of this Category [Optional].
        translation: The translation of this Category [Optional].
    """

    category_id: str
    type: str
    order: Optional[int] = None
    flowgeek_url: Optional[str] = None
    label: Optional[str] = None
    description: Optional[str] = None
    translation: Optional[str] = None

    class Config:
        extra = "allow"

    @validator("category_id")
    def category_id_max_length(cls, value):
        assert len(value) <= 255
        return value


Category.update_forward_refs()
