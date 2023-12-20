# This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

# coding: utf-8

from fastapi.testclient import TestClient
import pytest
import flowkit_ui_backend
from flowkit_ui_backend.models.category import Category  # noqa: F401
from flowkit_ui_backend.models.config import Config  # noqa: F401
from flowkit_ui_backend.models.data_provider import DataProvider  # noqa: F401
from flowkit_ui_backend.models.dataset import Dataset  # noqa: F401
from flowkit_ui_backend.models.indicator import Indicator  # noqa: F401
from flowkit_ui_backend.models.scope_mapping import ScopeMapping  # noqa: F401
from flowkit_ui_backend.models.spatial_resolution import SpatialResolution  # noqa: F401
from flowkit_ui_backend.models.temporal_resolution import TemporalResolution  # noqa: F401


@pytest.mark.skip("Post tests are broken")
@pytest.mark.asyncio
async def test_add_scope_mapping(client: TestClient):
    """Test case for add_scope_mapping

    
    """
    scope_mapping = flowkit_ui_backend.ScopeMapping()

    headers = {
        "Authorization": "Bearer special-key",
    }
    response = client.request(
        "POST",
        "/scope_mapping",
        headers=headers,
        json=scope_mapping,
    )

    # uncomment below to assert the status code of the HTTP response
    #assert response.status_code == 200


@pytest.mark.skip("Post tests are broken")
@pytest.mark.asyncio
async def test_create_category(client: TestClient):
    """Test case for create_category

    
    """
    category = flowkit_ui_backend.Category()

    headers = {
        "Authorization": "Bearer special-key",
    }
    response = client.request(
        "POST",
        "/categories",
        headers=headers,
        json=category,
    )

    # uncomment below to assert the status code of the HTTP response
    #assert response.status_code == 200


@pytest.mark.skip("Post tests are broken")
@pytest.mark.asyncio
async def test_create_data_provider(client: TestClient):
    """Test case for create_data_provider

    
    """
    data_provider = flowkit_ui_backend.DataProvider()

    headers = {
        "Authorization": "Bearer special-key",
    }
    response = client.request(
        "POST",
        "/data_providers",
        headers=headers,
        json=data_provider,
    )

    # uncomment below to assert the status code of the HTTP response
    #assert response.status_code == 200


@pytest.mark.skip("Post tests are broken")
@pytest.mark.asyncio
async def test_create_dataset(client: TestClient):
    """Test case for create_dataset

    
    """
    dataset = flowkit_ui_backend.Dataset()

    headers = {
        "Authorization": "Bearer special-key",
    }
    response = client.request(
        "POST",
        "/data",
        headers=headers,
        json=dataset,
    )

    # uncomment below to assert the status code of the HTTP response
    #assert response.status_code == 200


@pytest.mark.skip("Post tests are broken")
@pytest.mark.asyncio
async def test_create_indicator(client: TestClient):
    """Test case for create_indicator

    
    """
    indicator = flowkit_ui_backend.Indicator()

    headers = {
        "Authorization": "Bearer special-key",
    }
    response = client.request(
        "POST",
        "/indicators",
        headers=headers,
        json=indicator,
    )

    # uncomment below to assert the status code of the HTTP response
    #assert response.status_code == 200


@pytest.mark.skip("Post tests are broken")
@pytest.mark.asyncio
async def test_create_spatial_resolution(client: TestClient):
    """Test case for create_spatial_resolution

    
    """
    spatial_resolution = flowkit_ui_backend.SpatialResolution()

    headers = {
        "Authorization": "Bearer special-key",
    }
    response = client.request(
        "POST",
        "/spatial_resolutions",
        headers=headers,
        json=spatial_resolution,
    )

    # uncomment below to assert the status code of the HTTP response
    #assert response.status_code == 200


@pytest.mark.skip("Post tests are broken")
@pytest.mark.asyncio
async def test_create_temporal_resolution(client: TestClient):
    """Test case for create_temporal_resolution

    
    """
    temporal_resolution = flowkit_ui_backend.TemporalResolution()

    headers = {
        "Authorization": "Bearer special-key",
    }
    response = client.request(
        "POST",
        "/temporal_resolutions",
        headers=headers,
        json=temporal_resolution,
    )

    # uncomment below to assert the status code of the HTTP response
    #assert response.status_code == 200


@pytest.mark.asyncio
async def test_delete_category(client: TestClient):
    """Test case for delete_category

    
    """

    headers = {
        "Authorization": "Bearer special-key",
    }
    response = client.request(
        "DELETE",
        "/categories/{category_id}".format(category_id='category_id_example'),
        headers=headers,
    )

    # uncomment below to assert the status code of the HTTP response
    #assert response.status_code == 200


@pytest.mark.asyncio
async def test_delete_data_provider(client: TestClient):
    """Test case for delete_data_provider

    
    """

    headers = {
        "Authorization": "Bearer special-key",
    }
    response = client.request(
        "DELETE",
        "/data_providers/{dpid}".format(dpid=1),
        headers=headers,
    )

    # uncomment below to assert the status code of the HTTP response
    #assert response.status_code == 200


@pytest.mark.skip("This delete test is currently broken.")
@pytest.mark.asyncio
async def test_delete_dataset(client: TestClient):
    """Test case for delete_dataset

    
    """
    dataset = flowkit_ui_backend.Dataset()

    headers = {
        "Authorization": "Bearer special-key",
    }
    response = client.request(
        "DELETE",
        "/data",
        headers=headers,
        json=dataset,
    )

    # uncomment below to assert the status code of the HTTP response
    #assert response.status_code == 200


@pytest.mark.asyncio
async def test_delete_indicator(client: TestClient):
    """Test case for delete_indicator

    
    """

    headers = {
        "Authorization": "Bearer special-key",
    }
    response = client.request(
        "DELETE",
        "/indicators/{indicator_id}".format(indicator_id='indicator_id_example'),
        headers=headers,
    )

    # uncomment below to assert the status code of the HTTP response
    #assert response.status_code == 200


@pytest.mark.skip("This delete test is currently broken.")
@pytest.mark.asyncio
async def test_delete_scope_mapping(client: TestClient):
    """Test case for delete_scope_mapping

    
    """
    scope_mapping = flowkit_ui_backend.ScopeMapping()

    headers = {
        "Authorization": "Bearer special-key",
    }
    response = client.request(
        "DELETE",
        "/scope_mapping",
        headers=headers,
        json=scope_mapping,
    )

    # uncomment below to assert the status code of the HTTP response
    #assert response.status_code == 200


@pytest.mark.asyncio
async def test_delete_setup(client: TestClient):
    """Test case for delete_setup

    
    """

    headers = {
        "Authorization": "Bearer special-key",
    }
    response = client.request(
        "DELETE",
        "/setup",
        headers=headers,
    )

    # uncomment below to assert the status code of the HTTP response
    #assert response.status_code == 200


@pytest.mark.asyncio
async def test_delete_spatial_resolution(client: TestClient):
    """Test case for delete_spatial_resolution

    
    """

    headers = {
        "Authorization": "Bearer special-key",
    }
    response = client.request(
        "DELETE",
        "/spatial_resolutions/{srid}".format(srid=56),
        headers=headers,
    )

    # uncomment below to assert the status code of the HTTP response
    #assert response.status_code == 200


@pytest.mark.asyncio
async def test_delete_temporal_resolution(client: TestClient):
    """Test case for delete_temporal_resolution

    
    """

    headers = {
        "Authorization": "Bearer special-key",
    }
    response = client.request(
        "DELETE",
        "/temporal_resolutions/{trid}".format(trid=56),
        headers=headers,
    )

    # uncomment below to assert the status code of the HTTP response
    #assert response.status_code == 200


@pytest.mark.skip("Post tests are broken")
@pytest.mark.asyncio
async def test_replace_setup(client: TestClient):
    """Test case for replace_setup

    
    """
    config = flowkit_ui_backend.Config()

    headers = {
        "Authorization": "Bearer special-key",
    }
    response = client.request(
        "POST",
        "/setup",
        headers=headers,
        json=config,
    )

    # uncomment below to assert the status code of the HTTP response
    #assert response.status_code == 200


@pytest.mark.skip("Patch tests are broken")
@pytest.mark.asyncio
async def test_update_category(client: TestClient):
    """Test case for update_category

    
    """
    category = flowkit_ui_backend.Category()

    headers = {
        "Authorization": "Bearer special-key",
    }
    response = client.request(
        "PATCH",
        "/categories/{category_id}".format(category_id='category_id_example'),
        headers=headers,
        json=category,
    )

    # uncomment below to assert the status code of the HTTP response
    #assert response.status_code == 200


@pytest.mark.skip("Patch tests are broken")
@pytest.mark.asyncio
async def test_update_data_provider(client: TestClient):
    """Test case for update_data_provider

    
    """
    data_provider = flowkit_ui_backend.DataProvider()

    headers = {
        "Authorization": "Bearer special-key",
    }
    response = client.request(
        "PATCH",
        "/data_providers/{dpid}".format(dpid=1),
        headers=headers,
        json=data_provider,
    )

    # uncomment below to assert the status code of the HTTP response
    #assert response.status_code == 200


@pytest.mark.skip("Patch tests are broken")
@pytest.mark.asyncio
async def test_update_dataset(client: TestClient):
    """Test case for update_dataset

    
    """
    dataset = flowkit_ui_backend.Dataset()

    headers = {
        "Authorization": "Bearer special-key",
    }
    response = client.request(
        "PATCH",
        "/data",
        headers=headers,
        json=dataset,
    )

    # uncomment below to assert the status code of the HTTP response
    #assert response.status_code == 200


@pytest.mark.skip("Patch tests are broken")
@pytest.mark.asyncio
async def test_update_indicator(client: TestClient):
    """Test case for update_indicator

    
    """
    indicator = flowkit_ui_backend.Indicator()

    headers = {
        "Authorization": "Bearer special-key",
    }
    response = client.request(
        "PATCH",
        "/indicators/{indicator_id}".format(indicator_id='indicator_id_example'),
        headers=headers,
        json=indicator,
    )

    # uncomment below to assert the status code of the HTTP response
    #assert response.status_code == 200


@pytest.mark.skip("Patch tests are broken")
@pytest.mark.asyncio
async def test_update_setup(client: TestClient):
    """Test case for update_setup

    
    """
    config = flowkit_ui_backend.Config()

    headers = {
        "Authorization": "Bearer special-key",
    }
    response = client.request(
        "PATCH",
        "/setup",
        headers=headers,
        json=config,
    )

    # uncomment below to assert the status code of the HTTP response
    #assert response.status_code == 200


@pytest.mark.skip("Patch tests are broken")
@pytest.mark.asyncio
async def test_update_spatial_resolution(client: TestClient):
    """Test case for update_spatial_resolution

    
    """
    spatial_resolution = flowkit_ui_backend.SpatialResolution()

    headers = {
        "Authorization": "Bearer special-key",
    }
    response = client.request(
        "PATCH",
        "/spatial_resolutions/{srid}".format(srid=56),
        headers=headers,
        json=spatial_resolution,
    )

    # uncomment below to assert the status code of the HTTP response
    #assert response.status_code == 200


@pytest.mark.skip("Patch tests are broken")
@pytest.mark.asyncio
async def test_update_temporal_resolution(client: TestClient):
    """Test case for update_temporal_resolution

    
    """
    temporal_resolution = flowkit_ui_backend.TemporalResolution()

    headers = {
        "Authorization": "Bearer special-key",
    }
    response = client.request(
        "PATCH",
        "/temporal_resolutions/{trid}".format(trid=56),
        headers=headers,
        json=temporal_resolution,
    )

    # uncomment below to assert the status code of the HTTP response
    #assert response.status_code == 200

