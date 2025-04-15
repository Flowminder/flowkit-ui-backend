import pytest
from fastapi import FastAPI, Depends
from fastapi.security import SecurityScopes
from fastapi.testclient import TestClient
import pytest_asyncio
import aiomysql
import asyncio
import os
import pathlib

from flowkit_ui_backend.models.extra_models import TokenModel
from flowkit_ui_backend.db.db import (
    provision_db,
    run_script,
)
import flowkit_ui_backend.security_api


async def monkey_patched_get_token(security_scopes: SecurityScopes, token: str = Depends(flowkit_ui_backend.security_api.oauth2_code)):
    return TokenModel(sub="TEST USER", permissions=[])

@pytest.fixture
def get_dummy_token_auth0(monkeypatch):
    """
    Provides a test token.
    """
    monkeypatch.setattr("flowkit_ui_backend.security_api.get_token_auth0", monkey_patched_get_token)

@pytest.fixture()
def event_loop():
    policy = asyncio.get_event_loop_policy()
    loop = policy.new_event_loop()
    yield loop
    loop.close()


@pytest_asyncio.fixture()
async def fresh_pool(event_loop):
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
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PW"),
        db=os.getenv("DB_NAME"),
        loop=asyncio.get_event_loop(),
        autocommit=True,
        local_infile=True,
    )
    try:
        yield pool
    finally:
        async with pool.acquire() as conn:
            cur = await conn.cursor()
            await cur.execute("DROP DATABASE `flowkit_ui_backend`")
            await cur.execute("CREATE DATABASE `flowkit_ui_backend`")
        pool.close()
        await pool.wait_closed()


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
def app_with_dummied_out_security(get_dummy_token_auth0, populated_db) -> FastAPI:
    from flowkit_ui_backend.main import app as application
    return application


@pytest.fixture
def client_with_dummied_out_security(app_with_dummied_out_security) -> TestClient:
    with TestClient(app_with_dummied_out_security, base_url=f"http://testserver{os.environ['API_VERSION_URL_APPENDIX']}/") as client:
        yield client

@pytest.fixture
def app(get_dummy_token_auth0, populated_db) -> FastAPI:
    from flowkit_ui_backend.main import app as application
    return application


@pytest.fixture
def client(app) -> TestClient:
    with TestClient(app, base_url=f"http://testserver{os.environ['API_VERSION_URL_APPENDIX']}/") as client:
        yield client