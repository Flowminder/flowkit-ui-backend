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


class SingleLocationData(BaseModel):
    """

    SingleLocationData - a model defined in OpenAPI

        mdid: The mdid of this SingleLocationData [Optional].
        spatial_unit_id: The spatial_unit_id of this SingleLocationData.
        data: The data of this SingleLocationData [Optional].
    """

    mdid: Optional[int] = None
    spatial_unit_id: str
    data: Optional[float] = None

    class Config:
        extra = "allow"


SingleLocationData.update_forward_refs()
