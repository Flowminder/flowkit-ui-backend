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

from flowkit_ui_backend.models.category import Category
from flowkit_ui_backend.models.data_provider import DataProvider
from flowkit_ui_backend.models.indicator import Indicator
from flowkit_ui_backend.models.language import Language
from flowkit_ui_backend.models.spatial_resolution import SpatialResolution
from flowkit_ui_backend.models.temporal_resolution import TemporalResolution

# see https://github.com/OpenAPITools/openapi-generator/blob/master/modules/openapi-generator/src/main/resources/python-flask/model.mustache
# for how to validate enums


class Config(BaseModel):
    """

    Config - a model defined in OpenAPI

        languages: The languages of this Config.
        data_providers: The data_providers of this Config.
        categories: The categories of this Config.
        indicators: The indicators of this Config.
        temporal_resolutions: The temporal_resolutions of this Config.
        spatial_resolutions: The spatial_resolutions of this Config.
    """

    languages: List[Language]
    data_providers: List[DataProvider]
    categories: List[Category]
    indicators: List[Indicator]
    temporal_resolutions: List[TemporalResolution]
    spatial_resolutions: List[SpatialResolution]

    class Config:
        extra = "allow"


Config.update_forward_refs()
