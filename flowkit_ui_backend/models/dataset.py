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

from flowkit_ui_backend.models.data_input import DataInput
from flowkit_ui_backend.models.metadata import Metadata

# see https://github.com/OpenAPITools/openapi-generator/blob/master/modules/openapi-generator/src/main/resources/python-flask/model.mustache
# for how to validate enums


class Dataset(BaseModel):
    """

    Dataset - a model defined in OpenAPI

        metadata: The metadata of this Dataset.
        data_type: The data_type of this Dataset.
        data_input: The data_input of this Dataset.
    """

    metadata: Metadata
    data_type: str
    data_input: List[DataInput]

    class Config:
        extra = "allow"


Dataset.update_forward_refs()
