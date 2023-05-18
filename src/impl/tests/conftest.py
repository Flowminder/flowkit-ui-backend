import pytest
import pytest_asyncio
import aiomysql
import asyncio
import os
from flowkit_ui_backend.models.extra_models import TokenModel


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


@pytest.fixture
def token_model():
    """

    Returns
    -------
    TokenModel
        A token model with no permissions
    """
    return TokenModel(sub="test_subject", permissions=[])
