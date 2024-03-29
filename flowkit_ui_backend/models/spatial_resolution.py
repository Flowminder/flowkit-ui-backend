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


class SpatialResolution(BaseModel):
    """

    SpatialResolution - a model defined in OpenAPI

        srid: The srid of this SpatialResolution [Optional].
        label: The label of this SpatialResolution.
        index: The index of this SpatialResolution.
        description: The description of this SpatialResolution [Optional].
        boundaries: The boundaries of this SpatialResolution [Optional].
        translation: The translation of this SpatialResolution [Optional].
    """

    srid: Optional[int] = None
    label: str
    index: int
    description: Optional[str] = None
    boundaries: Optional[Dict[str, Any]] = None
    translation: Optional[str] = None

    class Config:
        extra = "allow"


SpatialResolution.update_forward_refs()
