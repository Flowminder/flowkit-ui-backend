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


class FlowData(BaseModel):
    """

    FlowData - a model defined in OpenAPI

        mdid: The mdid of this FlowData.
        origin: The origin of this FlowData.
        destination: The destination of this FlowData.
        data: The data of this FlowData [Optional].
    """

    mdid: int
    origin: str
    destination: str
    data: Optional[float] = None

    class Config:
        extra = "allow"


FlowData.update_forward_refs()
