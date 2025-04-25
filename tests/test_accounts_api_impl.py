# This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

import pytest
from unittest.mock import patch, AsyncMock
from fastapi import HTTPException
from auth0.exceptions import Auth0Error
from flowkit_ui_backend.models.user_metadata import UserMetadata
from flowkit_ui_backend.models.signup_cache import SignupCache
from flowkit_ui_backend.impl import accounts_api_impl


@pytest.mark.asyncio
async def test_get_user_invalid_token(mock_auth0_token_error):
    with pytest.raises(Auth0Error):
        await accounts_api_impl.get_user("bob")


@pytest.mark.asyncio
async def test_get_user_valid_token(mock_auth0):
    mock_auth0.users.return_value = "user-bob"
    result = await accounts_api_impl.get_user("bob")
    assert result == "user-bob"


@pytest.mark.asyncio
async def test_get_user_invalid(mock_auth0):
    with pytest.raises(HTTPException):
        await accounts_api_impl.get_user("bob")


@pytest.mark.asyncio
async def test_update_user_invalid_token(mock_auth0_token_error):
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
        await accounts_api_impl.update_user("bob", metadata)


@pytest.mark.asyncio
async def test_update_user_valid_token(mock_auth0):
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
    mock_auth0.users.return_value = "success"
    result = await accounts_api_impl.update_user("bob", metadata)
    assert result == None


@pytest.mark.asyncio
async def test_delete_user_valid_token(mock_auth0):
    result = await accounts_api_impl.delete_user("bob")
    assert result == None
