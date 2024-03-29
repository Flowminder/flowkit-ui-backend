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


class Metadata(BaseModel):
    """

    Metadata - a model defined in OpenAPI

        mdid: The mdid of this Metadata [Optional].
        date_added: The date_added of this Metadata [Optional].
        revision: The revision of this Metadata.
        category_id: The category_id of this Metadata.
        indicator_id: The indicator_id of this Metadata.
        srid: The srid of this Metadata.
        trid: The trid of this Metadata.
        dt: The dt of this Metadata [Optional].
        min_value: The min_value of this Metadata [Optional].
        max_value: The max_value of this Metadata [Optional].
    """

    mdid: Optional[int] = None
    date_added: Optional[str] = None
    revision: str
    category_id: str
    indicator_id: str
    srid: int
    trid: int
    dt: Optional[datetime] = None
    min_value: Optional[int] = None
    max_value: Optional[int] = None

    class Config:
        extra = "allow"

    @validator("date_added")
    def date_added_min_length(cls, value):
        assert len(value) >= 4
        return value

    @validator("date_added")
    def date_added_max_length(cls, value):
        assert len(value) <= 19
        return value

    @validator("date_added")
    def date_added_pattern(cls, value):
        assert value is not None and re.match(
            r"^([1-2][0-9]{3})((-(0[1-9]|1[0-2])(-(0[1-9]|[1-2][0-9]|3[0-1]))?(T(([0-1][0-9]|2[0-3]):([0-5][0-9])(:([0-5][0-9]))?))?)|(w(0[1-9]|[1-4][0-9]|5[0-3])))?$",
            value,
        )
        return value

    @validator("category_id")
    def category_id_max_length(cls, value):
        assert len(value) <= 255
        return value

    @validator("indicator_id")
    def indicator_id_max_length(cls, value):
        assert len(value) <= 255
        return value


Metadata.update_forward_refs()
