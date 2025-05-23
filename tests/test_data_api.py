# This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.
import os

# coding: utf-8

from fastapi.testclient import TestClient
import pytest
import flowkit_ui_backend
from flowkit_ui_backend.models.categories import Categories  # noqa: F401
from flowkit_ui_backend.models.category import Category  # noqa: F401
from flowkit_ui_backend.models.indicator import Indicator  # noqa: F401
from flowkit_ui_backend.models.indicators import Indicators  # noqa: F401
from flowkit_ui_backend.models.query_parameters import QueryParameters  # noqa: F401
from flowkit_ui_backend.models.query_result import QueryResult  # noqa: F401
from flowkit_ui_backend.models.spatial_resolution import SpatialResolution  # noqa: F401
from flowkit_ui_backend.models.time_range import TimeRange  # noqa: F401


@pytest.mark.asyncio
async def test_get_category(client_with_dummied_out_security: TestClient):
    """Test case for get_category"""

    headers = {
        "Authorization": "Bearer special-key",
    }
    response = client_with_dummied_out_security.get(
        "categories/residents",
        headers=headers,
    )

    # uncomment below to assert the status code of the HTTP response
    assert response.status_code == 200


@pytest.mark.asyncio
async def test_get_indicator(client_with_dummied_out_security: TestClient):
    """Test case for get_indicator"""

    headers = {
        "Authorization": "Bearer special-key",
    }
    response = client_with_dummied_out_security.request(
        "GET",
        "indicators/residents.residents",
        headers=headers,
    )

    # uncomment below to assert the status code of the HTTP response
    assert response.status_code == 200


@pytest.mark.asyncio
async def test_get_indicators_for_category(
    client_with_dummied_out_security: TestClient,
):
    """Test case for get_indicators_for_category"""

    headers = {
        "Authorization": "Bearer special-key",
    }
    response = client_with_dummied_out_security.request(
        "GET",
        "indicators_for_category/residents",
        headers=headers,
    )

    # uncomment below to assert the status code of the HTTP response
    assert response.status_code == 200


@pytest.mark.asyncio
async def test_get_spatial_resolution(client_with_dummied_out_security: TestClient):
    """Test case for get_spatial_resolution"""

    headers = {
        "Authorization": "Bearer special-key",
    }
    response = client_with_dummied_out_security.request(
        "GET",
        "spatial_resolutions/3",
        headers=headers,
    )

    # uncomment below to assert the status code of the HTTP response
    assert response.status_code == 200


@pytest.mark.asyncio
async def test_get_spatial_resolutions_for_category(
    client_with_dummied_out_security: TestClient,
):
    """Test case for get_spatial_resolutions_for_category"""

    headers = {
        "Authorization": "Bearer special-key",
    }
    response = client_with_dummied_out_security.request(
        "GET",
        "spatial_resolutions_for_category/residents",
        headers=headers,
    )

    # uncomment below to assert the status code of the HTTP response
    assert response.status_code == 200


@pytest.mark.asyncio
async def test_get_temporal_resolution(client_with_dummied_out_security: TestClient):
    """Test case for get_temporal_resolution"""

    headers = {
        "Authorization": "Bearer special-key",
    }
    response = client_with_dummied_out_security.request(
        "GET",
        "temporal_resolutions/2",
        headers=headers,
    )

    # uncomment below to assert the status code of the HTTP response
    assert response.status_code == 200


@pytest.mark.asyncio
async def test_get_temporal_resolutions_for_category(
    client_with_dummied_out_security: TestClient,
):
    """Test case for get_temporal_resolutions_for_category"""

    headers = {
        "Authorization": "Bearer special-key",
    }
    response = client_with_dummied_out_security.request(
        "GET",
        "temporal_resolutions_for_category/residents",
        headers=headers,
    )

    # uncomment below to assert the status code of the HTTP response
    assert response.status_code == 200


@pytest.mark.asyncio
async def test_get_time_range(client_with_dummied_out_security: TestClient):
    """Test case for get_time_range"""

    headers = {
        "Authorization": "Bearer special-key",
    }
    response = client_with_dummied_out_security.request(
        "GET",
        "timerange/residents/residents.residents/2/2",
        headers=headers,
    )

    # uncomment below to assert the status code of the HTTP response
    assert response.status_code == 200


@pytest.mark.asyncio
async def test_list_categories(client_with_dummied_out_security: TestClient):
    """Test case for list_categories"""

    headers = {
        "Authorization": "Bearer special-key",
    }
    response = client_with_dummied_out_security.request(
        "GET",
        "categories",
        headers=headers,
    )

    # uncomment below to assert the status code of the HTTP response
    assert response.status_code == 200


@pytest.mark.asyncio
async def test_list_indicators(client_with_dummied_out_security: TestClient):
    """Test case for list_indicators"""

    headers = {
        "Authorization": "Bearer special-key",
    }
    response = client_with_dummied_out_security.request(
        "GET",
        "indicators",
        headers=headers,
    )

    # uncomment below to assert the status code of the HTTP response
    assert response.status_code == 200


@pytest.mark.asyncio
async def test_list_spatial_resolutions(client_with_dummied_out_security: TestClient):
    """Test case for list_spatial_resolutions"""

    headers = {
        "Authorization": "Bearer special-key",
    }
    response = client_with_dummied_out_security.request(
        "GET",
        "spatial_resolutions",
        headers=headers,
    )

    # uncomment below to assert the status code of the HTTP response
    assert response.status_code == 200


@pytest.mark.asyncio
async def test_list_temporal_resolutions(client_with_dummied_out_security: TestClient):
    """Test case for list_temporal_resolutions"""

    headers = {
        "Authorization": "Bearer special-key",
    }
    response = client_with_dummied_out_security.request(
        "GET",
        "temporal_resolutions",
        headers=headers,
    )

    # uncomment below to assert the status code of the HTTP response
    assert response.status_code == 200


@pytest.mark.asyncio
async def test_run_csv_query(client_with_dummied_out_security: TestClient):
    """Test case for run_csv_query"""
    query_parameters = dict(
        category_id="relocations",
        indicator_id="relocations.relocations",
        srid=3,
        trid=2,
        start_date="2020-02-01",
        duration=1,
    )

    headers = {
        "Authorization": "Bearer special-key",
    }
    response = client_with_dummied_out_security.request(
        "POST",
        "csv",
        headers=headers,
        json=query_parameters,
    )

    # uncomment below to assert the status code of the HTTP response
    assert response.status_code == 200


@pytest.mark.asyncio
async def test_run_query(client_with_dummied_out_security: TestClient):
    """Test case for run_query"""
    query_parameters = dict(
        category_id="relocations",
        indicator_id="relocations.relocations",
        srid=3,
        trid=2,
        start_date="2020-02-01",
        duration=1,
    )

    headers = {
        "Authorization": "Bearer special-key",
    }
    response = client_with_dummied_out_security.request(
        "POST",
        "query",
        headers=headers,
        json=query_parameters,
    )

    # uncomment below to assert the status code of the HTTP response

    assert response.status_code == 200
    assert response.json() == dict(
        min=6040.0,
        max=6040.0,
        mdids=None,
        data_by_date={"2020-02": {"HT0111-01": {"HT0111-02": 6040.0}}},
    )
