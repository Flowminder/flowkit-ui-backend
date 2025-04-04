# This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

# coding: utf-8

from fastapi.testclient import TestClient
import pytest
import flowkit_ui_backend
from flowkit_ui_backend.models.config import Config  # noqa: F401
from flowkit_ui_backend.models.data_providers import DataProviders  # noqa: F401
from flowkit_ui_backend.models.heartbeat import Heartbeat  # noqa: F401


@pytest.mark.asyncio
async def test_get_setup(client: TestClient):
    """Test case for get_setup"""

    headers = {}
    response = client.request(
        "GET",
        "/setup",
        headers=headers,
    )

    # uncomment below to assert the status code of the HTTP response
    assert response.status_code == 200


@pytest.mark.asyncio
async def test_heartbeat(client: TestClient):
    """Test case for heartbeat"""

    headers = {}
    response = client.request(
        "GET",
        "/heartbeat",
        headers=headers,
    )

    # uncomment below to assert the status code of the HTTP response
    assert response.status_code == 200


@pytest.mark.asyncio
async def test_list_data_providers(client: TestClient):
    """Test case for list_data_providers"""

    headers = {}
    response = client.request(
        "GET",
        "/data_providers",
        headers=headers,
    )

    # uncomment below to assert the status code of the HTTP response
    assert response.status_code == 200
