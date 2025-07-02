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

from flowkit_ui_backend.models.signup_cache import SignupCache

# see https://github.com/OpenAPITools/openapi-generator/blob/master/modules/openapi-generator/src/main/resources/python-flask/model.mustache
# for how to validate enums


class UserMetadata(BaseModel):
    """

    UserMetadata - a model defined in OpenAPI

        preferred_language: The preferred_language of this UserMetadata.
        show_tutorial: The show_tutorial of this UserMetadata.
        signup_cache: The signup_cache of this UserMetadata.
        roles_expiry: The roles_expiry of this UserMetadata [Optional].
        account_expiry: The account_expiry of this UserMetadata [Optional].
    """

    preferred_language: str
    show_tutorial: bool
    signup_cache: SignupCache
    roles_expiry: Optional[str] = None
    account_expiry: Optional[str] = None

    class Config:
        extra = "allow"

    @validator("roles_expiry")
    def roles_expiry_min_length(cls, value):
        assert len(value) >= 4
        return value

    @validator("roles_expiry")
    def roles_expiry_max_length(cls, value):
        assert len(value) <= 19
        return value

    @validator("roles_expiry")
    def roles_expiry_pattern(cls, value):
        assert value is not None and re.match(
            r"^([1-2][0-9]{3})((-(0[1-9]|1[0-2])(-(0[1-9]|[1-2][0-9]|3[0-1]))?(T(([0-1][0-9]|2[0-3]):([0-5][0-9])(:([0-5][0-9]))?))?)|(w(0[1-9]|[1-4][0-9]|5[0-3])))?$",
            value,
        )
        return value

    @validator("account_expiry")
    def account_expiry_min_length(cls, value):
        assert len(value) >= 4
        return value

    @validator("account_expiry")
    def account_expiry_max_length(cls, value):
        assert len(value) <= 19
        return value

    @validator("account_expiry")
    def account_expiry_pattern(cls, value):
        assert value is not None and re.match(
            r"^([1-2][0-9]{3})((-(0[1-9]|1[0-2])(-(0[1-9]|[1-2][0-9]|3[0-1]))?(T(([0-1][0-9]|2[0-3]):([0-5][0-9])(:([0-5][0-9]))?))?)|(w(0[1-9]|[1-4][0-9]|5[0-3])))?$",
            value,
        )
        return value


UserMetadata.update_forward_refs()
