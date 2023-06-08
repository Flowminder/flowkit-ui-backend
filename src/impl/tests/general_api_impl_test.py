# This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

import os
import pytest
from fastapi import HTTPException
from flowkit_ui_backend.impl.apis import general_api_impl
from flowkit_ui_backend.models.data_providers import DataProviders
from flowkit_ui_backend.models.data_provider import DataProvider
from flowkit_ui_backend.models.language import Language
from flowkit_ui_backend.models.config import Config


DPS = DataProviders(
    data_providers=[
        DataProvider(dpid=1, name="Foo", logo="logo.png", url="https://foo.bar"),
        DataProvider(dpid=2, name="Bar", logo="logo.jpg", url="https://bar.baz"),
    ]
)


@pytest.mark.asyncio
async def test_get_setup(mocker, provisioned_db):
    languages = [
        Language(lid=1, code="FO", name="Foo", flag="foo.svg", default=True),
        Language(lid=2, code="BA", name="Bar", flag="bar.svg", default=False),
        Language(lid=2, code="BZ", name="Baz", flag="baz.svg", default=False),
    ]

    mocker.patch(
        "flowkit_ui_backend.impl.apis.general_api_impl.db.select_data",
        side_effect=[languages, DPS.data_providers],
    )

    result = await general_api_impl.get_setup(pool=provisioned_db)

    assert type(result) == Config
    assert len(result.data_providers) == 2
    assert len(result.languages) == 3


@pytest.mark.asyncio
async def test_list_data_providers(mocker, provisioned_db):
    mocker.patch(
        "flowkit_ui_backend.impl.apis.general_api_impl.db.select_data",
        return_value=DPS.data_providers,
    )

    result = await general_api_impl.list_data_providers(pool=provisioned_db)
    assert len(result.data_providers) == 2


@pytest.mark.asyncio
async def test_get_data_provider_invalid(mocker, provisioned_db):
    mocker.patch(
        "flowkit_ui_backend.impl.apis.general_api_impl.db.select_data",
        side_effect=[[]],
    )

    with pytest.raises(HTTPException):
        await general_api_impl.get_data_provider(dpid=1, pool=provisioned_db)


@pytest.mark.asyncio
async def test_get_data_provider(mocker, provisioned_db):
    mocker.patch(
        "flowkit_ui_backend.impl.apis.general_api_impl.db.select_data",
        return_value=[DPS.data_providers[0]],
    )

    result = await general_api_impl.get_data_provider(dpid=1, pool=provisioned_db)
    assert result == DPS.data_providers[0]


@pytest.mark.asyncio
async def test_heartbeat(provisioned_db):
    result = await general_api_impl.heartbeat(pool=provisioned_db)
    assert result.python_package == os.getenv("APP_NAME")
