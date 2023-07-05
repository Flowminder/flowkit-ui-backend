# This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

import pytest
import datetime
from http import HTTPStatus
from fastapi import HTTPException
from flowkit_ui_backend.impl.apis import data_api_impl
from flowkit_ui_backend.models.query_parameters import QueryParameters
from flowkit_ui_backend.models.time_range import TimeRange
from flowkit_ui_backend.models.single_location_data import SingleLocationData
from flowkit_ui_backend.models.categories import Categories
from flowkit_ui_backend.models.indicators import Indicators
from flowkit_ui_backend.models.spatial_resolutions import SpatialResolutions
from flowkit_ui_backend.models.temporal_resolutions import TemporalResolutions
from flowkit_ui_backend.models.category import Category
from flowkit_ui_backend.models.indicator import Indicator
from flowkit_ui_backend.models.metadata import Metadata
from flowkit_ui_backend.models.spatial_resolution import SpatialResolution
from flowkit_ui_backend.models.temporal_resolution import TemporalResolution
from flowkit_ui_backend.models.extra_models import TokenModel


# some simple test objects
cat = Category(category_id="foo", type="single_location")
ind = Indicator(category_id="foo", indicator_id="foo.bar")
sr = SpatialResolution(label="foo", index=1)
tr = TemporalResolution(
    label="foo",
    index=1,
    date_format="%Y",
    relativedelta_unit="years",
    relativedelta_num=1,
    default_selected=3,
)
md = Metadata(
    revision="rev",
    date_added="2022-10-14T08:52:52",
    category_id="foo",
    indicator_id="foo.bar",
    srid=1,
    trid=1,
    dt=datetime.datetime.fromisoformat("1970-01-01"),
)


@pytest.mark.asyncio
async def test_list_categories_empty(mocker, fresh_pool, token_model):
    mocker.patch(
        "flowkit_ui_backend.impl.apis.data_api_impl.db.select_data",
        side_effect=[[]],
    )

    result = await data_api_impl.list_categories(pool=fresh_pool, token_model=token_model)
    assert result == Categories(categories=[])


@pytest.mark.asyncio
async def test_get_category(mocker, fresh_pool, token_model):
    mocker.patch(
        "flowkit_ui_backend.impl.apis.data_api_impl.db.select_data",
        side_effect=[[cat]],
    )

    result = await data_api_impl.get_category("foo", pool=fresh_pool, token_model=token_model)
    assert result == cat


@pytest.mark.asyncio
async def test_get_category_invalid(mocker, fresh_pool, token_model):
    mocker.patch(
        "flowkit_ui_backend.impl.apis.data_api_impl.db.select_data",
        side_effect=[[]],
    )

    with pytest.raises(HTTPException):
        await data_api_impl.get_category("foo", pool=fresh_pool, token_model=token_model)


@pytest.mark.asyncio
async def test_list_indicators_empty(mocker, fresh_pool, token_model):
    mocker.patch(
        "flowkit_ui_backend.impl.apis.data_api_impl.db.select_data",
        side_effect=[[]],
    )

    result = await data_api_impl.list_indicators(pool=fresh_pool, token_model=token_model)
    assert result == Indicators(indicators=[])


@pytest.mark.asyncio
async def test_get_indicator(mocker, fresh_pool, token_model):
    mocker.patch(
        "flowkit_ui_backend.impl.apis.data_api_impl.db.select_data",
        side_effect=[[ind]],
    )

    result = await data_api_impl.get_indicator("foo", pool=fresh_pool, token_model=token_model)
    assert result == ind


@pytest.mark.asyncio
async def test_get_indicator_invalid(mocker, fresh_pool, token_model):
    mocker.patch(
        "flowkit_ui_backend.impl.apis.data_api_impl.db.select_data",
        side_effect=[[]],
    )

    with pytest.raises(HTTPException):
        await data_api_impl.get_indicator("foo", pool=fresh_pool, token_model=token_model)


@pytest.mark.asyncio
async def test_get_indicators_for_category(mocker, fresh_pool, token_model):
    mocker.patch(
        "flowkit_ui_backend.impl.apis.data_api_impl.db.select_data",
        side_effect=[[ind, ind]],
    )

    result = await data_api_impl.get_indicators_for_category(
        "foo", pool=fresh_pool, token_model=token_model
    )
    # TODO: add meaningful tests


@pytest.mark.asyncio
async def test_list_spatial_resolutions_empty(mocker, fresh_pool, token_model):
    mocker.patch(
        "flowkit_ui_backend.impl.apis.data_api_impl.db.select_data",
        side_effect=[[]],
    )

    result = await data_api_impl.list_spatial_resolutions(pool=fresh_pool, token_model=token_model)
    assert result == SpatialResolutions(spatial_resolutions=[])


@pytest.mark.asyncio
async def test_get_spatial_resolution(mocker, fresh_pool, token_model):
    mocker.patch(
        "flowkit_ui_backend.impl.apis.data_api_impl.db.select_data",
        side_effect=[[sr]],
    )

    result = await data_api_impl.get_spatial_resolution(
        "foo", pool=fresh_pool, token_model=token_model
    )
    assert result == sr


@pytest.mark.asyncio
async def test_get_spatial_resolution_invalid(mocker, fresh_pool, token_model):
    mocker.patch(
        "flowkit_ui_backend.impl.apis.data_api_impl.db.select_data",
        side_effect=[[]],
    )

    with pytest.raises(HTTPException):
        await data_api_impl.get_spatial_resolution("foo", pool=fresh_pool, token_model=token_model)


@pytest.mark.asyncio
async def test_get_spatial_resolutions_for_category(mocker, fresh_pool, token_model):
    mocker.patch(
        "flowkit_ui_backend.impl.apis.data_api_impl.db.select_data",
        side_effect=[[md], [sr, sr]],
    )

    result = await data_api_impl.get_spatial_resolutions_for_category(
        category_id="foo", pool=fresh_pool, token_model=token_model
    )
    # TODO: add meaningful tests


@pytest.mark.asyncio
async def test_get_spatial_resolutions_for_category_error(mocker, fresh_pool, token_model):
    mocker.patch(
        "flowkit_ui_backend.impl.apis.data_api_impl.db.select_data",
        side_effect=[[], HTTPException(status_code=HTTPStatus.INTERNAL_SERVER_ERROR)],
    )

    with pytest.raises(HTTPException):
        await data_api_impl.get_spatial_resolutions_for_category(
            category_id="foo", pool=fresh_pool, token_model=token_model
        )


@pytest.mark.asyncio
async def test_list_temporal_resolutions_empty(mocker, fresh_pool, token_model):
    mocker.patch(
        "flowkit_ui_backend.impl.apis.data_api_impl.db.select_data",
        side_effect=[[]],
    )

    result = await data_api_impl.list_temporal_resolutions(pool=fresh_pool, token_model=token_model)
    assert result == TemporalResolutions(temporal_resolutions=[])


@pytest.mark.asyncio
async def test_get_temporal_resolution(mocker, fresh_pool, token_model):
    mocker.patch(
        "flowkit_ui_backend.impl.apis.data_api_impl.db.select_data",
        side_effect=[[tr]],
    )

    result = await data_api_impl.get_temporal_resolution(
        "foo", pool=fresh_pool, token_model=token_model
    )
    assert result == tr


@pytest.mark.asyncio
async def test_get_temporal_resolution_invalid(mocker, fresh_pool, token_model):
    mocker.patch(
        "flowkit_ui_backend.impl.apis.data_api_impl.db.select_data",
        side_effect=[[]],
    )

    with pytest.raises(HTTPException):
        await data_api_impl.get_temporal_resolution("foo", pool=fresh_pool, token_model=token_model)


@pytest.mark.asyncio
async def test_get_temporal_resolutions_for_category(mocker, fresh_pool, token_model):
    mocker.patch(
        "flowkit_ui_backend.impl.apis.data_api_impl.db.select_data",
        side_effect=[[md], [tr, tr]],
    )

    result = await data_api_impl.get_temporal_resolutions_for_category(
        category_id="foo", pool=fresh_pool, token_model=token_model
    )
    # TODO: add meaningful tests


@pytest.mark.asyncio
async def test_get_temporal_resolutions_for_category_error(mocker, fresh_pool, token_model):
    mocker.patch(
        "flowkit_ui_backend.impl.apis.data_api_impl.db.select_data",
        side_effect=[[], HTTPException(status_code=HTTPStatus.INTERNAL_SERVER_ERROR)],
    )

    with pytest.raises(HTTPException):
        await data_api_impl.get_temporal_resolutions_for_category(
            category_id="foo", pool=fresh_pool, token_model=token_model
        )


@pytest.mark.asyncio
async def test_get_time_range_empty(mocker, fresh_pool, token_model):
    mocker.patch(
        "flowkit_ui_backend.impl.apis.data_api_impl.db.select_data",
        side_effect=[[tr]],
    )
    mocker.patch(
        "flowkit_ui_backend.impl.apis.data_api_impl.db.run",
        side_effect=[(None, [])],
    )

    result = await data_api_impl.get_time_range(
        category_id="foo",
        indicator_id="bar",
        srid=1,
        trid=1,
        pool=fresh_pool,
        token_model=token_model,
    )
    assert result.start_date is None
    assert result.end_date is None
    assert result.all_dates is None


@pytest.mark.asyncio
async def test_get_time_range(mocker, fresh_pool, token_model):
    mocker.patch(
        "flowkit_ui_backend.impl.apis.data_api_impl.db.select_data",
        side_effect=[[tr]],
    )
    mocker.patch(
        "flowkit_ui_backend.impl.apis.data_api_impl.db.run",
        side_effect=[
            (
                None,
                [
                    (datetime.datetime.fromisoformat("1970-01-01"), 1, 50),
                    (datetime.datetime.fromisoformat("1972-01-01"), 10, 100),
                ],
            )
        ],
    )

    result = await data_api_impl.get_time_range(
        category_id="foo",
        indicator_id="bar",
        srid=1,
        trid=1,
        pool=fresh_pool,
        token_model=token_model,
    )
    assert result == TimeRange(
        start_date="1970",
        end_date="1972",
        all_dates=["1970", "1971", "1972"],
        min_value=1,
        max_value=100,
    )


@pytest.mark.asyncio
async def test_run_query_unknown_query_type(mocker, fresh_pool, token_model):
    mocker.patch(
        "flowkit_ui_backend.impl.apis.data_api_impl.db.select_data",
        side_effect=[[cat], [tr]],
    )

    mocker.patch(
        "flowkit_ui_backend.impl.apis.data_api_impl.db.run",
        side_effect=[(None, None)],
    )

    with pytest.raises(HTTPException):
        query_parameters = QueryParameters(
            category_id="foo",
            indicator_id="foo.bar",
            srid=1,
            trid=1,
            start_date="2022-03-17",
            duration=1,
        )
        await data_api_impl.run_query(
            query_parameters=query_parameters, pool=fresh_pool, token_model=token_model
        )


@pytest.mark.asyncio
async def test_run_query(mocker, fresh_pool):
    # mocker.patch(
    #    "flowkit_ui_backend.impl.apis.data_api_impl.db.select_data",
    #    side_effect=[[cat], [tr]],
    # )
    # mocker.patch(
    #    "flowkit_ui_backend.impl.apis.data_api_impl.db.run",
    #    side_effect=[
    #        (
    #            None,
    #            [
    #                (
    #                    None,
    #                    1,
    #                    None,
    #                    None,
    #                    None,
    #                    None,
    #                    None,
    #                    None,
    #                    datetime.datetime.fromisoformat("1970-01-01"),
    #                )
    #            ],
    #        ),
    #    ],
    # )

    query_parameters = QueryParameters(
        category_id="foo",
        indicator_id="foo.bar",
        srid=1,
        trid=1,
        start_date="2022-03-17",
        duration=1,
    )
    # TODO: not sure how to mock this
    # result = await data_api_impl.run_query(query_parameters=query_parameters, pool=fresh_pool)
    # assert result == QueryResult(min=1.23, max=1.23, data_by_date={"1970": {"foo": 1.23}})


@pytest.mark.asyncio
async def test_run_query_no_metadata(mocker, fresh_pool, token_model):
    mocker.patch(
        "flowkit_ui_backend.impl.apis.data_api_impl.db.select_data",
        side_effect=[
            [cat],
            [tr],
            [SingleLocationData(mdid=1, spatial_unit_id="foo", data=1.23)],
        ],
    )
    mocker.patch(
        "flowkit_ui_backend.impl.apis.data_api_impl.db.run",
        side_effect=[(None, None)],
    )

    query_parameters = QueryParameters(
        category_id="foo",
        indicator_id="foo.bar",
        srid=1,
        trid=1,
        start_date="2022-03-17",
        duration=1,
    )
    with pytest.raises(HTTPException):
        await data_api_impl.run_query(
            query_parameters=query_parameters, pool=fresh_pool, token_model=token_model
        )


@pytest.mark.asyncio
async def test_run_query_no_data(mocker, fresh_pool):
    # mocker.patch(
    #    "flowkit_ui_backend.impl.apis.data_api_impl.db.select_data",
    #    side_effect=[[cat], [tr], []],
    # )
    # mocker.patch(
    #    "flowkit_ui_backend.impl.apis.data_api_impl.db.run",
    #    side_effect=[
    #        (None, [(None, 1, None, None, None, None, None, None, "1970-01-01")]),
    #        (None, None),
    #    ],
    # )
    # TODO: not sure how to mock this
    query_parameters = QueryParameters(
        category_id="foo",
        indicator_id="foo.bar",
        srid=1,
        trid=1,
        start_date="2022-03-17",
        duration=1,
    )
    # with pytest.raises(HTTPException):
    #    await data_api_impl.run_query(query_parameters=query_parameters, pool=fresh_pool)


@pytest.mark.asyncio
async def test_csv_generation(populated_db):
    params = QueryParameters(
        category_id="residents",
        indicator_id="residents.residents",
        srid=3,
        trid=2,
        start_date="2020-02-01",
        duration=3,
        mdids_only=False,
    )
    out = await data_api_impl.run_csv_query(
        params,
        pool=populated_db,
        token_model=TokenModel(sub="TEST", permissions=["admin"]),
    )
    assert out.split("\n")[0].split(",") == ["date", "area_code", "value"]


@pytest.mark.asyncio
async def test_flow_csv_generation(populated_db):
    params = QueryParameters(
        category_id="relocations",
        indicator_id="relocations.relocations",
        srid=3,
        trid=2,
        start_date="2020-02-01",
        duration=3,
        mdids_only=False,
    )
    out = await data_api_impl.run_csv_query(
        params,
        pool=populated_db,
        token_model=TokenModel(sub="TEST", permissions=["admin"]),
    )
    assert out.split("\n")[0].split(",") == ["date", "origin_code", "destination_code", "value"]
