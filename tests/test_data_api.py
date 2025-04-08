# This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

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
from flowkit_ui_backend.models.spatial_resolutions import (
    SpatialResolutions,
)  # noqa: F401
from flowkit_ui_backend.models.temporal_resolution import (
    TemporalResolution,
)  # noqa: F401
from flowkit_ui_backend.models.temporal_resolutions import (
    TemporalResolutions,
)  # noqa: F401
from flowkit_ui_backend.models.time_range import TimeRange  # noqa: F401


@pytest.mark.asyncio
async def test_get_category(client: TestClient):
    """Test case for get_category"""

    headers = {
        "Authorization": "Bearer special-key",
    }
    response = client.request(
        "GET",
        "/categories/{category_id}".format(category_id="category_id_example"),
        headers=headers,
    )

    # uncomment below to assert the status code of the HTTP response
    # assert response.status_code == 200


@pytest.mark.asyncio
async def test_get_indicator(client: TestClient):
    """Test case for get_indicator"""

    headers = {
        "Authorization": "Bearer special-key",
    }
    response = client.request(
        "GET",
        "/indicators/{indicator_id}".format(indicator_id="indicator_id_example"),
        headers=headers,
    )

    # uncomment below to assert the status code of the HTTP response
    # assert response.status_code == 200


@pytest.mark.asyncio
async def test_get_indicators_for_category(client: TestClient):
    """Test case for get_indicators_for_category"""

    headers = {
        "Authorization": "Bearer special-key",
    }
    response = client.request(
        "GET",
        "/indicators_for_category/{category_id}".format(
            category_id="category_id_example"
        ),
        headers=headers,
    )

    # uncomment below to assert the status code of the HTTP response
    # assert response.status_code == 200


@pytest.mark.asyncio
async def test_get_spatial_resolution(client: TestClient):
    """Test case for get_spatial_resolution"""

    headers = {
        "Authorization": "Bearer special-key",
    }
    response = client.request(
        "GET",
        "/spatial_resolutions/{srid}".format(srid=56),
        headers=headers,
    )

    # uncomment below to assert the status code of the HTTP response
    # assert response.status_code == 200


@pytest.mark.asyncio
async def test_get_spatial_resolutions_for_category(client: TestClient):
    """Test case for get_spatial_resolutions_for_category"""

    headers = {
        "Authorization": "Bearer special-key",
    }
    response = client.request(
        "GET",
        "/spatial_resolutions_for_category/{category_id}".format(
            category_id="category_id_example"
        ),
        headers=headers,
    )

    # uncomment below to assert the status code of the HTTP response
    # assert response.status_code == 200


@pytest.mark.asyncio
async def test_get_temporal_resolution(client: TestClient):
    """Test case for get_temporal_resolution"""

    headers = {
        "Authorization": "Bearer special-key",
    }
    response = client.request(
        "GET",
        "/temporal_resolutions/{trid}".format(trid=56),
        headers=headers,
    )

    # uncomment below to assert the status code of the HTTP response
    # assert response.status_code == 200


@pytest.mark.asyncio
async def test_get_temporal_resolutions_for_category(client: TestClient):
    """Test case for get_temporal_resolutions_for_category"""

    headers = {
        "Authorization": "Bearer special-key",
    }
    response = client.request(
        "GET",
        "/temporal_resolutions_for_category/{category_id}".format(
            category_id="category_id_example"
        ),
        headers=headers,
    )

    # uncomment below to assert the status code of the HTTP response
    # assert response.status_code == 200


@pytest.mark.asyncio
async def test_get_time_range(client: TestClient):
    """Test case for get_time_range"""

    headers = {
        "Authorization": "Bearer special-key",
    }
    response = client.request(
        "GET",
        "/timerange/{category_id}/{indicator_id}/{srid}/{trid}".format(
            category_id="category_id_example",
            indicator_id="indicator_id_example",
            srid=56,
            trid=56,
        ),
        headers=headers,
    )

    # uncomment below to assert the status code of the HTTP response
    # assert response.status_code == 200


@pytest.mark.asyncio
async def test_list_categories(client: TestClient):
    """Test case for list_categories"""

    headers = {
        "Authorization": "Bearer special-key",
    }
    response = client.request(
        "GET",
        "/categories",
        headers=headers,
    )

    # uncomment below to assert the status code of the HTTP response
    # assert response.status_code == 200


@pytest.mark.asyncio
async def test_list_indicators(client: TestClient):
    """Test case for list_indicators"""

    headers = {
        "Authorization": "Bearer special-key",
    }
    response = client.request(
        "GET",
        "/indicators",
        headers=headers,
    )

    # uncomment below to assert the status code of the HTTP response
    # assert response.status_code == 200


@pytest.mark.asyncio
async def test_list_spatial_resolutions(client: TestClient):
    """Test case for list_spatial_resolutions"""

    headers = {
        "Authorization": "Bearer special-key",
    }
    response = client.request(
        "GET",
        "/spatial_resolutions",
        headers=headers,
    )

    # uncomment below to assert the status code of the HTTP response
    # assert response.status_code == 200


@pytest.mark.asyncio
async def test_list_temporal_resolutions(client: TestClient):
    """Test case for list_temporal_resolutions"""

    headers = {
        "Authorization": "Bearer special-key",
    }
    response = client.request(
        "GET",
        "/temporal_resolutions",
        headers=headers,
    )

    # uncomment below to assert the status code of the HTTP response
    # assert response.status_code == 200


@pytest.mark.skip("Post tests are broken")
@pytest.mark.asyncio
async def test_run_csv_query(client: TestClient):
    """Test case for run_csv_query"""
    query_parameters = flowkit_ui_backend.QueryParameters()

    headers = {
        "Authorization": "Bearer special-key",
    }
    response = client.request(
        "POST",
        "/csv",
        headers=headers,
        json=query_parameters,
    )

    # uncomment below to assert the status code of the HTTP response
    # assert response.status_code == 200


@pytest.mark.skip("Post tests are broken")
@pytest.mark.asyncio
async def test_run_query(client: TestClient):
    """Test case for run_query"""
    query_parameters = flowkit_ui_backend.QueryParameters()

    headers = {
        "Authorization": "Bearer special-key",
    }
    response = client.request(
        "POST",
        "/query",
        headers=headers,
        json=query_parameters,
    )

    # uncomment below to assert the status code of the HTTP response
    # assert response.status_code == 200


@pytest.mark.asyncio
async def test_get_latest_date(client: TestClient):
    response = client.request("GET", "/latest_date")

    # assert response.status_code == 200
