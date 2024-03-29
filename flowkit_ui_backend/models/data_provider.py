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


class DataProvider(BaseModel):
    """

    DataProvider - a model defined in OpenAPI

        dpid: The dpid of this DataProvider [Optional].
        name: The name of this DataProvider.
        logo: The logo of this DataProvider [Optional].
        url: The url of this DataProvider [Optional].
        translation: The translation of this DataProvider [Optional].
    """

    dpid: Optional[int] = None
    name: str
    logo: Optional[str] = None
    url: Optional[str] = None
    translation: Optional[str] = None

    class Config:
        extra = "allow"


DataProvider.update_forward_refs()
