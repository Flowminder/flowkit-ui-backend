import pytest
import pytest_asyncio
import aiomysql
import asyncio
import os
import pathlib
from flowkit_ui_backend.models.extra_models import TokenModel
from flowkit_ui_backend.impl.util.db import provision_db, run_script, PERSISTENT_FIRST_RUN


@pytest_asyncio.fixture
async def fresh_pool():
    """
    Creates and yields up a fresh pool connected to a database, cleans it up at exit

    Yields
    ------
    Pool
        An aiomysql pool connected to the db
    """
    pool = await aiomysql.create_pool(
        host=os.getenv("CONTAINER_NAME_DB"),
        port=int(os.getenv("DB_PORT_CONTAINER")),
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
        pool.close()
        await pool.wait_closed()


@pytest_asyncio.fixture
async def provisioned_db(fresh_pool, monkeypatch):
    monkeypatch.setenv("FORCE_DB_SETUP", "1")
    pathlib.Path(PERSISTENT_FIRST_RUN).unlink(missing_ok=True)
    await provision_db(fresh_pool)
    try:
        yield fresh_pool
    finally:
        async with fresh_pool.acquire() as conn:
            cur = await conn.cursor()
            await cur.execute("DROP DATABASE `flowkit_ui_backend`")
            await cur.execute("CREATE DATABASE `flowkit_ui_backend`")
        pathlib.Path(PERSISTENT_FIRST_RUN).unlink(missing_ok=False)


@pytest_asyncio.fixture
async def populated_db(provisioned_db):
    print("Populating db")
    await run_script(str(pathlib.Path(__file__).parent / "test_data.sql"), pool=provisioned_db)
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
