import asyncio

import fastapi
import pytest
from flowkit_ui_backend.models.extra_models import TokenModel
from flowkit_ui_backend.models.query_parameters import QueryParameters
from flowkit_ui_backend.impl.apis.data_api_impl import run_query


@pytest.mark.asyncio
async def test_access_restricted(populated_db):
    tm = TokenModel(sub="TEST", permissions=[])
    params = QueryParameters(
        category_id="residents",
        indicator_id="residents.residents",
        srid=3,
        trid=2,
        start_date="2020-02-01",
        duration=1,
        mdids_only=True,
    )
    with pytest.raises(fastapi.HTTPException):
        await run_query(query_parameters=params, token_model=tm, pool=populated_db)


@pytest.mark.asyncio
async def test_access_allowed_for_admin(populated_db):
    tm = TokenModel(sub="TEST", permissions=["admin"])
    params = QueryParameters(
        category_id="residents",
        indicator_id="residents.residents",
        srid=3,
        trid=2,
        start_date="2020-02-01",
        duration=1,
        mdids_only=True,
    )
    await run_query(query_parameters=params, token_model=tm, pool=populated_db)
