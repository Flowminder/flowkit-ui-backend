# This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

# coding: utf-8

from fastapi.testclient import TestClient
import pytest
import flowkit_ui_backend
from flowkit_ui_backend.models.user_metadata import UserMetadata  # noqa: F401


@pytest.mark.asyncio
async def test_delete_user(client_with_dummied_out_security: TestClient):
    """Test case for delete_user"""

    headers = {
        "Authorization": "Bearer special-key",
    }
    response = client_with_dummied_out_security.request(
        "DELETE",
        "users/{uid}".format(uid="user-4e128f03-a086-4167-81bd-bcfcc0175744"),
        headers=headers,
    )

    # uncomment below to assert the status code of the HTTP response
    assert response.status_code == 204


@pytest.mark.asyncio
async def test_get_user(client_with_dummied_out_security: TestClient):
    """Test case for get_user"""

    headers = {
        "Authorization": "Bearer special-key",
    }
    response = client_with_dummied_out_security.request(
        "GET",
        "users/{uid}".format(uid="user-4e128f03-a086-4167-81bd-bcfcc0175744"),
        headers=headers,
    )

    # uncomment below to assert the status code of the HTTP response
    assert response.status_code == 200


@pytest.mark.asyncio
async def test_reset_password(client_with_dummied_out_security: TestClient):
    """Test case for reset_password"""

    headers = {
        "Authorization": "Bearer special-key",
    }
    response = client_with_dummied_out_security.request(
        "GET",
        "reset_password/{email}".format(email="user@example.com"),
        headers=headers,
    )

    # uncomment below to assert the status code of the HTTP response
    assert response.status_code == 200


@pytest.mark.skip("Patch tests are broken")
@pytest.mark.asyncio
async def test_update_user(client_with_dummied_out_security: TestClient):
    """Test case for update_user"""
    user_metadata = flowkit_ui_backend.UserMetadata()

    headers = {
        "Authorization": "Bearer special-key",
    }
    response = client_with_dummied_out_security.request(
        "PATCH",
        "users/{uid}".format(uid="user-4e128f03-a086-4167-81bd-bcfcc0175744"),
        headers=headers,
        json=user_metadata,
    )

    # uncomment below to assert the status code of the HTTP response
    assert response.status_code == 200
