# This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

import pytest
from unittest.mock import patch, AsyncMock, Mock
from fastapi import HTTPException
from auth0.exceptions import Auth0Error
from flowkit_ui_backend.models.user_metadata import UserMetadata
from flowkit_ui_backend.models.signup_cache import SignupCache
from flowkit_ui_backend.impl import accounts_api_impl


@pytest.fixture
def mock_auth0(settings):
    auth0 = Mock()
    auth0.users = AsyncMock()
    yield auth0


@pytest.mark.asyncio
async def test_get_user_invalid_token(mock_auth0):
    mock_auth0.users.get_async = AsyncMock(
        side_effect=Auth0Error(
            status_code=400, error_code="Bad token", message="Bad token"
        )
    )
    with pytest.raises(Auth0Error):
        await accounts_api_impl.get_user(
            "bob",
            mock_auth0,
        )


@pytest.mark.asyncio
async def test_get_user_valid_token(mock_auth0):
    mock_auth0.users.get_async = AsyncMock(return_value="user-bob")
    result = await accounts_api_impl.get_user(
        "bob",
        mock_auth0,
    )
    assert result == "user-bob"


@pytest.mark.asyncio
async def test_get_user_invalid(mock_auth0):
    mock_auth0.users.get_async = AsyncMock(return_value=None)
    with pytest.raises(HTTPException):
        await accounts_api_impl.get_user("bob", mock_auth0)


@pytest.mark.asyncio
async def test_update_user_invalid_token(mock_auth0):
    mock_auth0.users.update_async = AsyncMock(
        side_effect=Auth0Error(
            status_code=400, error_code="Bad token", message="Bad token"
        )
    )
    metadata = UserMetadata(
        preferred_language="fr",
        show_tutorial=False,
        signup_cache=SignupCache(
            first_name="bob",
            last_name="smith",
            email="bob.smith@example.com",
            org="foo",
            purpose="...",
            terms=True,
            no_harm=True,
            privacy=True,
            marketing=False,
        ),
    )
    with pytest.raises(Auth0Error):
        await accounts_api_impl.update_user("bob", metadata, mock_auth0)


@pytest.mark.asyncio
async def test_update_user_valid_token(mock_auth0):
    mock_auth0.users.update_async = AsyncMock(return_value="success")
    metadata = UserMetadata(
        preferred_language="fr",
        show_tutorial=False,
        signup_cache=SignupCache(
            first_name="bob",
            last_name="smith",
            email="bob.smith@example.com",
            org="foo",
            purpose="...",
            terms=True,
            no_harm=True,
            privacy=True,
            marketing=False,
        ),
    )
    result = await accounts_api_impl.update_user("bob", metadata, mock_auth0)
    assert result == None


@pytest.mark.asyncio
async def test_delete_user_valid_token(mock_auth0):
    mock_auth0.users.delete_async = AsyncMock(return_value="success")
    result = await accounts_api_impl.delete_user("bob", mock_auth0)
    assert result == None


@patch(
    "auth0.asyncify.asyncify",
    side_effect=AsyncMock(side_effect=Auth0Error),
)
@pytest.mark.asyncio
async def test_get_management_api_m2m_token_fail(mock_auth0):
    result = await accounts_api_impl.get_management_api_m2m_token(
        auth0_domain="DUMMY_DOMAIN",
        auth0_client_id="DUMMY_ID",
        auth0_client_secret="DUMMY_SECRET",
    )
    assert result is None
