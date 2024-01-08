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


class SignupCache(BaseModel):
    """

    SignupCache - a model defined in OpenAPI

        first_name: The first_name of this SignupCache.
        last_name: The last_name of this SignupCache.
        email: The email of this SignupCache.
        org: The org of this SignupCache [Optional].
        industry: The industry of this SignupCache [Optional].
        purpose: The purpose of this SignupCache.
        terms: The terms of this SignupCache [Optional].
        no_harm: The no_harm of this SignupCache [Optional].
        privacy: The privacy of this SignupCache [Optional].
        marketing: The marketing of this SignupCache [Optional].
    """

    first_name: str
    last_name: str
    email: str
    org: Optional[str] = None
    industry: Optional[str] = None
    purpose: str
    terms: Optional[bool] = None
    no_harm: Optional[bool] = None
    privacy: Optional[bool] = None
    marketing: Optional[bool] = None

    class Config:
        extra = "allow"


SignupCache.update_forward_refs()
