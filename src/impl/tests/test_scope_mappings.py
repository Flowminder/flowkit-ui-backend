import asyncio
import datetime

import fastapi
import pytest
from flowkit_ui_backend.models.extra_models import TokenModel
from flowkit_ui_backend.models.scope_mapping import ScopeMapping
from flowkit_ui_backend.models.query_parameters import QueryParameters
from flowkit_ui_backend.impl.apis.data_api_impl import run_query
from flowkit_ui_backend.impl.apis.maintenance_api_impl import create_dataset, add_scope_mapping
from flowkit_ui_backend.models.dataset import Dataset
from flowkit_ui_backend.models.data_input import DataInput
from flowkit_ui_backend.models.metadata import Metadata



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


@pytest.mark.asyncio
async def test_access_granted_by_mapping(populated_db):
    """
    A newly added dataset should be accessible to admin and staff, but not to free or premium.
    """
    mdid, status_code = await create_dataset(
        dataset=Dataset(
            data_type="single_location",
            data_input=[
                DataInput(
                    spatial_unit_ids=["foo"],
                    data=0,
                )
            ],
            metadata=Metadata(
                revision="rev",
                date_added="2022-10-14T08:52:52",
                category_id="residents",
                indicator_id="residents.residents",
                srid=3,
                trid=2,
                dt=datetime.datetime.fromisoformat("1970-01-01"),
            ),
        ),
        pool=populated_db,
    )
    params = QueryParameters(
        category_id="residents",
        indicator_id="residents.residents",
        srid=3,
        trid=2,
        start_date="1970-01-01",
        duration=1,
        mdids_only=True,
    )
    await run_query(query_parameters=params, token_model=TokenModel(sub="TEST", permissions=["admin"]), pool=populated_db)
    with pytest.raises(fastapi.HTTPException):
        await run_query(query_parameters=params, token_model=TokenModel(sub="TEST", permissions=["test_scope"]),
                    pool=populated_db)
    # now add scope mapping
    await add_scope_mapping(scope_mapping=ScopeMapping(scope="test_scope", mdid=mdid), pool=populated_db)
    await run_query(query_parameters=params, token_model=TokenModel(sub="TEST", permissions=["test_scope"]),
                    pool=populated_db)