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


class Language(BaseModel):
    """

    Language - a model defined in OpenAPI

        lid: The lid of this Language [Optional].
        code: The code of this Language [Optional].
        name: The name of this Language.
        flag: The flag of this Language [Optional].
        default: The default of this Language [Optional].
    """

    lid: Optional[int] = None
    code: Optional[str] = None
    name: str
    flag: Optional[str] = None
    default: Optional[bool] = None

    class Config:
        extra = "allow"

    @validator("code")
    def code_min_length(cls, value):
        assert len(value) >= 2
        return value

    @validator("code")
    def code_max_length(cls, value):
        assert len(value) <= 2
        return value


Language.update_forward_refs()
