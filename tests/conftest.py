from typing import Annotated, Optional

import pytest
from auth0.management.async_auth0 import AsyncAuth0
from fastapi import FastAPI, Depends
from fastapi.security import SecurityScopes
from fastapi.testclient import TestClient
import pytest_asyncio
import aiomysql
import asyncio
import os
import pathlib

from flowkit_ui_backend.impl import accounts_api_impl
from flowkit_ui_backend.impl.accounts_api_impl import auth0_management, management_api_m2m_token
from flowkit_ui_backend.models.extra_models import TokenModel
from flowkit_ui_backend.db.db import (
    provision_db,
    run_script,
)
from flowkit_ui_backend.util.config import get_settings, Settings
import flowkit_ui_backend.security_api
from flowkit_ui_backend.security_api import get_token_auth0


class StubAuth0Users:
    def __init__(self, return_value):
        self.return_value = return_value

    async def get_async(self, uid):
        return self.return_value

    async def update_async(self, uid, meta):
        return self.return_value

    async def delete_async(self, uid):
        return self.return_value


class StubAuth0:
    def __init__(self, return_value=None):
        self.users = StubAuth0Users(return_value)

stub_auth_0 = StubAuth0()

@pytest.fixture
def mock_auth0():
    return stub_auth_0

async def auth0_management_override(
    settings: Annotated[Settings, Depends(get_settings)],
) -> AsyncAuth0:
    print("Overriding auth0")
    return stub_auth_0

async def get_token_auth0_override(
    security_scopes: SecurityScopes,
    token: str = Depends(flowkit_ui_backend.security_api.oauth2_code),
):
    return TokenModel(sub="TEST USER", permissions=["admin"])


@pytest.fixture()
def event_loop():
    policy = asyncio.get_event_loop_policy()
    loop = policy.new_event_loop()
    yield loop
    loop.close()


@pytest.fixture
def settings():
    return get_settings()


@pytest_asyncio.fixture()
async def fresh_pool(event_loop, settings):
    """
    Creates and yields up a fresh pool connected to a database, cleans it up at exit

    Yields
    ------
    Pool
        An aiomysql pool connected to the db
    """
    pool = await aiomysql.create_pool(
        host="localhost",
        port=int(os.environ["DB_PORT_HOST"]),
        user=settings.db_user,
        password=settings.db_pw.get_secret_value(),
        db=settings.db_name,
        loop=asyncio.get_event_loop(),
        autocommit=True,
        local_infile=True,
    )
    async with pool.acquire() as conn:
        cur = await conn.cursor()
        await cur.execute("DROP DATABASE IF EXISTS `flowkit_ui_backend`")
        await cur.execute("CREATE DATABASE `flowkit_ui_backend`")
        yield pool


@pytest_asyncio.fixture()
def monkey_session():
    with pytest.MonkeyPatch.context() as mp:
        yield mp


@pytest_asyncio.fixture()
async def provisioned_db(fresh_pool, monkey_session):
    monkey_session.setenv("FORCE_DB_SETUP", "1")
    await provision_db(fresh_pool)
    yield fresh_pool


@pytest_asyncio.fixture()
async def populated_db(provisioned_db):
    print("Populating db")
    await run_script(
        str(pathlib.Path(__file__).parent / "test_data.sql"), pool=provisioned_db
    )
    yield provisioned_db


@pytest.fixture
def token_model():
    """

    Returns
    -------
    TokenModel
        A token model with no permissions
    """
    return TokenModel(sub="test_subject", permissions=[])


@pytest.fixture
def admin_token_model():
    """
    Returns
    -------
    TokenModel
        A token model with admin permissions
    """
    return TokenModel(sub="test_subject", permissions=["admin"])


@pytest.fixture
def app_with_dummied_out_security(populated_db) -> FastAPI:
    from flowkit_ui_backend.main import app as application
    application.dependency_overrides[accounts_api_impl.auth0_management] = auth0_management_override
    application.dependency_overrides[get_token_auth0] = get_token_auth0_override
    return application


@pytest.fixture
def client_with_dummied_out_security(app_with_dummied_out_security) -> TestClient:
    with TestClient(
        app_with_dummied_out_security,
        base_url=f"http://testserver{os.environ['API_VERSION_URL_APPENDIX']}/",
    ) as client:
        yield client


@pytest.fixture
def app(populated_db) -> FastAPI:
    from flowkit_ui_backend.main import app as application

    application.dependency_overrides[get_token_auth0] = get_token_auth0_override
    return application


@pytest.fixture
def client(app) -> TestClient:
    with TestClient(
        app, base_url=f"http://testserver{os.environ['API_VERSION_URL_APPENDIX']}/"
    ) as client:
        yield client
