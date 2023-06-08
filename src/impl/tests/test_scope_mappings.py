import datetime

import fastapi
import pytest
from flowkit_ui_backend.models.extra_models import TokenModel
from flowkit_ui_backend.models.indicators import Indicators
from flowkit_ui_backend.models.indicator import Indicator
from flowkit_ui_backend.models.categories import Categories
from flowkit_ui_backend.models.category import Category
from flowkit_ui_backend.models.spatial_resolutions import SpatialResolutions
from flowkit_ui_backend.models.spatial_resolution import SpatialResolution
from flowkit_ui_backend.models.temporal_resolutions import TemporalResolutions
from flowkit_ui_backend.models.temporal_resolution import TemporalResolution
from flowkit_ui_backend.models.scope_mapping import ScopeMapping
from flowkit_ui_backend.models.query_parameters import QueryParameters
from flowkit_ui_backend.impl.apis.data_api_impl import (
    run_query,
    list_categories,
    list_indicators,
    list_spatial_resolutions,
    list_temporal_resolutions,
)
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
    Newly added datasets should be accessible to admin but nobody else.
    Adding a mapping for a scope should make them accessible only if the token provides
    that scope.
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
    await run_query(
        query_parameters=params,
        token_model=TokenModel(sub="TEST", permissions=["admin"]),
        pool=populated_db,
    )
    with pytest.raises(fastapi.HTTPException):
        await run_query(
            query_parameters=params,
            token_model=TokenModel(sub="TEST", permissions=["test_scope"]),
            pool=populated_db,
        )
    # now add scope mapping
    await add_scope_mapping(
        scope_mapping=ScopeMapping(scope="test_scope", mdid=mdid), pool=populated_db
    )
    await run_query(
        query_parameters=params,
        token_model=TokenModel(sub="TEST", permissions=["test_scope"]),
        pool=populated_db,
    )


@pytest.mark.asyncio
async def test_empty_hidden(populated_db):
    """
    Visibility of categories, indicators, etc. should be contingent on having
    access to at least one dataset in them.
    """

    listers = [
        list_categories,
        list_indicators,
        list_spatial_resolutions,
        list_temporal_resolutions,
    ]
    lister_results = [
        await lister(
            pool=populated_db, token_model=TokenModel(sub="TEST", permissions=["test_scope"])
        )
        for lister in listers
    ]
    assert lister_results == [
        Categories(categories=[]),
        Indicators(indicators=[]),
        SpatialResolutions(spatial_resolutions=[]),
        TemporalResolutions(temporal_resolutions=[]),
    ]


@pytest.mark.asyncio
async def test_visible_with_mapping(populated_db):
    """
    Categories etc. should be visible if a token provides a scope with a mapping
    for at least one of their datasets.
    """
    await add_scope_mapping(
        scope_mapping=ScopeMapping(scope="test_scope", mdid=24), pool=populated_db
    )

    categories = (
        await list_categories(
            pool=populated_db, token_model=TokenModel(sub="TEST", permissions=["test_scope"])
        )
    ).categories
    indicators = (
        await list_indicators(
            pool=populated_db, token_model=TokenModel(sub="TEST", permissions=["test_scope"])
        )
    ).indicators
    srs = (
        await list_spatial_resolutions(
            pool=populated_db, token_model=TokenModel(sub="TEST", permissions=["test_scope"])
        )
    ).spatial_resolutions
    trs = (
        await list_temporal_resolutions(
            pool=populated_db, token_model=TokenModel(sub="TEST", permissions=["test_scope"])
        )
    ).temporal_resolutions
    assert categories[0].category_id == "residents"
    assert len(categories) == 1
    assert indicators[0].indicator_id == "residents.departed"
    assert len(indicators) == 1
    assert srs[0].srid == 3
    assert len(srs) == 1
    assert trs[0].trid == 2
    assert len(trs) == 1
