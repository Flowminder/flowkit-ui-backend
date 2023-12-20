# This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

import pytest
import datetime
from http import HTTPStatus
from fastapi import HTTPException
from flowkit_ui_backend.impl import maintenance_api_impl
from flowkit_ui_backend.models.extra_models import TokenModel
from flowkit_ui_backend.models.config import Config
from flowkit_ui_backend.models.data_provider import DataProvider
from flowkit_ui_backend.models.dataset import Dataset
from flowkit_ui_backend.models.language import Language
from flowkit_ui_backend.models.data_input import DataInput
from flowkit_ui_backend.models.metadata import Metadata
from flowkit_ui_backend.models.category import Category
from flowkit_ui_backend.models.indicator import Indicator
from flowkit_ui_backend.models.spatial_resolution import SpatialResolution
from flowkit_ui_backend.models.temporal_resolution import TemporalResolution


token_bearerAuth = TokenModel(sub="Bob", permissions=[])

# some simple test objects
dp = DataProvider(name="foo")
cat = Category(category_id="foo", type="single_location")
ind = Indicator(category_id="foo", indicator_id="foo.bar")
sr = SpatialResolution(label="foo", index=1)
tr = TemporalResolution(
    label="foo",
    index=1,
    relativedelta_unit="days",
    relativedelta_num=7,
    default_selected=14,
)
languages = [
    Language(lid=1, code="FO", name="Foo", flag="foo.svg", default=True),
    Language(lid=2, code="BA", name="Bar", flag="bar.svg", default=False),
    Language(lid=2, code="BZ", name="Baz", flag="baz.svg", default=False),
]
ds = Dataset(
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
        category_id="foo",
        indicator_id="foo.bar",
        srid=1,
        trid=1,
        dt=datetime.datetime.fromisoformat("1970-01-01"),
    ),
)


@pytest.mark.asyncio
async def test_create_data_provider(mocker, provisioned_db):
    mocker.patch(
        "flowkit_ui_backend.db.db.add_resource_with_unique_id",
        side_effect=[(dp, HTTPStatus.CREATED)],
    )

    content, status_code = await maintenance_api_impl.create_data_provider(dp, pool=provisioned_db)
    assert status_code == HTTPStatus.CREATED
    assert type(content) == DataProvider
    assert content == dp


@pytest.mark.asyncio
async def test_create_category(mocker, provisioned_db):
    mocker.patch(
        "flowkit_ui_backend.db.db.add_resource_with_unique_id",
        side_effect=[(cat, HTTPStatus.CREATED)],
    )

    content, status_code = await maintenance_api_impl.create_category(cat, pool=provisioned_db)
    assert status_code == HTTPStatus.CREATED
    assert type(content) == Category
    assert content == cat


@pytest.mark.asyncio
async def test_create_indicator_success(mocker, provisioned_db):
    mocker.patch(
        "flowkit_ui_backend.db.db.select_data",
        side_effect=[[cat]],
    )
    mocker.patch(
        "flowkit_ui_backend.db.db.add_resource_with_unique_id",
        side_effect=[(ind, HTTPStatus.CREATED)],
    )
    mocker.patch(
        "flowkit_ui_backend.db.db.run",
        side_effect=[(None, [("table_name", "CREATE TABLE...")]), (None, None)],
    )

    content, status_code = await maintenance_api_impl.create_indicator(ind, pool=provisioned_db)
    assert status_code == HTTPStatus.CREATED
    assert content == ind


@pytest.mark.asyncio
async def test_create_indicator_category_exists(mocker, provisioned_db):
    mocker.patch(
        "flowkit_ui_backend.db.db.select_data",
        side_effect=[None],
    )

    with pytest.raises(HTTPException):
        await maintenance_api_impl.create_indicator(ind, pool=provisioned_db)


@pytest.mark.asyncio
async def test_create_indicator_indicator_exists(mocker, provisioned_db):
    mocker.patch(
        "flowkit_ui_backend.db.db.select_data",
        side_effect=[[cat]],
    )
    mocker.patch(
        "flowkit_ui_backend.db.db.add_resource_with_unique_id",
        side_effect=[(ind, HTTPStatus.SEE_OTHER)],
    )

    result, status = await maintenance_api_impl.create_indicator(ind, pool=provisioned_db)
    assert status == HTTPStatus.SEE_OTHER
    assert result == ind


@pytest.mark.asyncio
async def test_create_spatial_resolution(mocker, provisioned_db):
    mocker.patch(
        "flowkit_ui_backend.db.db.add_resource_with_unique_id",
        side_effect=[(sr, HTTPStatus.CREATED)],
    )

    content, status_code = await maintenance_api_impl.create_spatial_resolution(
        sr, pool=provisioned_db
    )
    assert status_code == HTTPStatus.CREATED
    assert type(content) == SpatialResolution
    assert content == sr


@pytest.mark.asyncio
async def test_create_temporal_resolution(mocker, provisioned_db):
    mocker.patch(
        "flowkit_ui_backend.db.db.add_resource_with_unique_id",
        side_effect=[(tr, HTTPStatus.CREATED)],
    )

    content, status_code = await maintenance_api_impl.create_temporal_resolution(
        tr, pool=provisioned_db
    )
    assert status_code == HTTPStatus.CREATED
    assert type(content) == TemporalResolution
    assert content == tr


@pytest.mark.asyncio
async def test_update_data_provider_success(mocker, provisioned_db):
    mocker.patch(
        "flowkit_ui_backend.impl.maintenance_api_impl.db.update_resource_with_unique_id",
        side_effect=[None],
    )

    result = await maintenance_api_impl.update_data_provider(
        1, DataProvider(dpid=1, name="bar"), pool=provisioned_db
    )
    assert result is None


@pytest.mark.asyncio
async def test_update_data_provider_failure(mocker, provisioned_db):
    mocker.patch(
        "flowkit_ui_backend.impl.maintenance_api_impl.db.update_resource_with_unique_id",
        side_effect=[HTTPException(status_code=HTTPStatus.BAD_REQUEST, detail="Error")],
    )

    with pytest.raises(HTTPException):
        await maintenance_api_impl.update_data_provider(
            1, DataProvider(dpid=1, name="bar"), pool=provisioned_db
        )


@pytest.mark.asyncio
async def test_update_category_success(mocker, provisioned_db):
    mocker.patch(
        "flowkit_ui_backend.impl.maintenance_api_impl.db.update_resource_with_unique_id",
        side_effect=[None],
    )

    result = await maintenance_api_impl.update_category(cat.category_id, cat, pool=provisioned_db)
    assert result is None


@pytest.mark.asyncio
async def test_update_category_failure(mocker, provisioned_db):
    mocker.patch(
        "flowkit_ui_backend.impl.maintenance_api_impl.db.update_resource_with_unique_id",
        side_effect=[HTTPException(status_code=HTTPStatus.BAD_REQUEST, detail="Error")],
    )

    with pytest.raises(HTTPException):
        await maintenance_api_impl.update_category(cat.category_id, cat, pool=provisioned_db)


@pytest.mark.asyncio
async def test_update_indicator_success(mocker, provisioned_db):
    mocker.patch(
        "flowkit_ui_backend.impl.maintenance_api_impl.db.update_resource_with_unique_id",
        side_effect=[None],
    )

    result = await maintenance_api_impl.update_indicator(ind.indicator_id, ind, pool=provisioned_db)
    assert result is None


@pytest.mark.asyncio
async def test_update_indicator_failure(mocker, provisioned_db):
    mocker.patch(
        "flowkit_ui_backend.impl.maintenance_api_impl.db.update_resource_with_unique_id",
        side_effect=[HTTPException(status_code=HTTPStatus.BAD_REQUEST, detail="Error")],
    )

    with pytest.raises(HTTPException):
        await maintenance_api_impl.update_indicator(ind.indicator_id, ind, pool=provisioned_db)


@pytest.mark.asyncio
async def test_update_spatial_resolution_success(mocker, provisioned_db):
    mocker.patch(
        "flowkit_ui_backend.impl.maintenance_api_impl.db.update_resource_with_unique_id",
        side_effect=[None],
    )

    result = await maintenance_api_impl.update_spatial_resolution(sr.srid, sr, pool=provisioned_db)
    assert result is None


@pytest.mark.asyncio
async def test_update_spatial_resolution_failure(mocker, provisioned_db):
    mocker.patch(
        "flowkit_ui_backend.impl.maintenance_api_impl.db.update_resource_with_unique_id",
        side_effect=[HTTPException(status_code=HTTPStatus.BAD_REQUEST, detail="Error")],
    )

    with pytest.raises(HTTPException):
        await maintenance_api_impl.update_spatial_resolution(sr.srid, sr, pool=provisioned_db)


@pytest.mark.asyncio
async def test_update_temporal_resolution_success(mocker, provisioned_db):
    mocker.patch(
        "flowkit_ui_backend.impl.maintenance_api_impl.db.update_resource_with_unique_id",
        side_effect=[None],
    )

    result = await maintenance_api_impl.update_temporal_resolution(tr.trid, tr, pool=provisioned_db)
    assert result is None


@pytest.mark.asyncio
async def test_update_temporal_resolution_failure(mocker, provisioned_db):
    mocker.patch(
        "flowkit_ui_backend.impl.maintenance_api_impl.db.update_resource_with_unique_id",
        side_effect=[HTTPException(status_code=HTTPStatus.BAD_REQUEST, detail="Error")],
    )

    with pytest.raises(HTTPException):
        await maintenance_api_impl.update_temporal_resolution(tr.trid, tr, pool=provisioned_db)


@pytest.mark.asyncio
async def test_delete_data_provider(mocker, provisioned_db):
    mocker.patch(
        "flowkit_ui_backend.impl.maintenance_api_impl.db.delete_data",
        side_effect=[None],
    )

    result = await maintenance_api_impl.delete_data_provider("1", pool=provisioned_db)
    assert result is None


@pytest.mark.asyncio
async def test_delete_category(mocker, provisioned_db):
    mocker.patch(
        "flowkit_ui_backend.impl.maintenance_api_impl.db.delete_data",
        side_effect=[None],
    )

    result = await maintenance_api_impl.delete_category("foo", pool=provisioned_db)
    assert result is None


@pytest.mark.asyncio
async def test_delete_indicator_success(mocker, provisioned_db):
    mocker.patch(
        "flowkit_ui_backend.db.db.select_data",
        side_effect=[[ind], [cat]],
    )
    mocker.patch(
        "flowkit_ui_backend.db.db.delete_data",
        side_effect=[None],
    )
    mocker.patch(
        "flowkit_ui_backend.db.db.run",
        side_effect=[(None, None), (None, None)],
    )

    result = await maintenance_api_impl.delete_indicator("foo", pool=provisioned_db)
    assert result is None


@pytest.mark.asyncio
async def test_delete_indicator_indicator_doesnt_exist(mocker, provisioned_db):
    mocker.patch(
        "flowkit_ui_backend.db.db.select_data",
        side_effect=[[ind], []],
    )

    with pytest.raises(HTTPException):
        await maintenance_api_impl.delete_indicator("foo.bar", pool=provisioned_db)


@pytest.mark.asyncio
async def test_delete_indicator_category_doesnt_exist(mocker, provisioned_db):
    mocker.patch(
        "flowkit_ui_backend.db.db.select_data",
        side_effect=[[]],
    )

    with pytest.raises(HTTPException):
        await maintenance_api_impl.delete_indicator("foo.foo", pool=provisioned_db)


@pytest.mark.asyncio
async def test_delete_indicator_failed_to_drop_table(mocker, provisioned_db):
    mocker.patch(
        "flowkit_ui_backend.db.db.select_data",
        side_effect=[[ind], [cat]],
    )
    mocker.patch(
        "flowkit_ui_backend.db.db.delete_data",
        side_effect=[None],
    )
    mocker.patch(
        "flowkit_ui_backend.db.db.run",
        side_effect=[(None, None), Exception("Could not drop table")],
    )

    with pytest.raises(HTTPException):
        await maintenance_api_impl.delete_indicator("bar", pool=provisioned_db)


@pytest.mark.asyncio
async def test_delete_spatial_resolution(mocker, provisioned_db):
    mocker.patch(
        "flowkit_ui_backend.impl.maintenance_api_impl.db.delete_data",
        side_effect=[None],
    )

    result = await maintenance_api_impl.delete_spatial_resolution("1", pool=provisioned_db)
    assert result is None


@pytest.mark.asyncio
async def test_delete_temporal_resolution(mocker, provisioned_db):
    mocker.patch(
        "flowkit_ui_backend.impl.maintenance_api_impl.db.delete_data",
        side_effect=[None],
    )

    result = await maintenance_api_impl.delete_temporal_resolution("1", pool=provisioned_db)
    assert result is None


@pytest.mark.asyncio
async def test_replace_setup(mocker, provisioned_db):
    mocker.patch(
        "flowkit_ui_backend.impl.maintenance_api_impl.db.delete_data",
        side_effect=[None, None, None, None, None, None, None, None, None, None, None],
    )
    mocker.patch(
        "flowkit_ui_backend.impl.maintenance_api_impl.db.select_data",
        side_effect=[[], [ind], [cat], [cat]],
    )
    mocker.patch(
        "flowkit_ui_backend.impl.maintenance_api_impl.db.insert_data",
        side_effect=[None, None, None, None, None],
    )
    mocker.patch(
        "flowkit_ui_backend.db.db.add_resource_with_unique_id",
        side_effect=[(ind, HTTPStatus.CREATED)],
    )
    mocker.patch(
        "flowkit_ui_backend.impl.maintenance_api_impl.db.run",
        side_effect=[
            (None, None),
            (None, None),
            (None, [("foo", "bar")]),
            (None, None),
        ],
    )
    mocker.patch(
        "flowkit_ui_backend.impl.data_api_impl.get_indicator",
        side_effect=[ind],
    )

    config = Config(
        languages=[],
        data_providers=[],
        categories=[],
        indicators=[],
        spatial_resolutions=[],
        temporal_resolutions=[],
        boundaries=[],
    )
    result = await maintenance_api_impl.replace_setup(config, pool=provisioned_db)
    assert result is None


@pytest.mark.asyncio
async def test_update_setup_no_indicator(mocker, provisioned_db):
    mocker.patch(
        "flowkit_ui_backend.impl.maintenance_api_impl.db.delete_data",
        side_effect=[None, None, None, None, None],
    )
    mocker.patch(
        "flowkit_ui_backend.impl.maintenance_api_impl.db.select_data",
        side_effect=[[cat], [cat]],
    )
    mocker.patch(
        "flowkit_ui_backend.impl.maintenance_api_impl.db.insert_data",
        side_effect=[None, None, None, None, None],
    )
    mocker.patch(
        "flowkit_ui_backend.db.db.add_resource_with_unique_id",
        side_effect=[(ind, HTTPStatus.CREATED)],
    )
    mocker.patch(
        "flowkit_ui_backend.impl.maintenance_api_impl.db.run",
        side_effect=[
            (None, None),
            (None, None),
            (None, [("foo", "bar")]),
            (None, None),
        ],
    )
    mocker.patch(
        "flowkit_ui_backend.impl.data_api_impl.get_indicator",
        side_effect=[ind],
    )

    config = Config(
        languages=[],
        data_providers=[dp],
        categories=[cat],
        indicators=[],
        spatial_resolutions=[sr],
        temporal_resolutions=[tr],
    )
    result = await maintenance_api_impl.update_setup(config, pool=provisioned_db)
    assert result is None


@pytest.mark.asyncio
async def test_update_setup_indicator_exists(mocker, provisioned_db):
    mocker.patch(
        "flowkit_ui_backend.impl.maintenance_api_impl.db.delete_data",
        side_effect=[None, None, None, None, None, None],
    )
    mocker.patch(
        "flowkit_ui_backend.impl.maintenance_api_impl.db.select_data",
        side_effect=[[ind], [cat], [cat]],
    )
    mocker.patch(
        "flowkit_ui_backend.impl.maintenance_api_impl.db.insert_data",
        side_effect=[None, None, None, None, None],
    )
    mocker.patch(
        "flowkit_ui_backend.db.db.add_resource_with_unique_id",
        side_effect=[(ind, HTTPStatus.CREATED)],
    )
    mocker.patch(
        "flowkit_ui_backend.impl.maintenance_api_impl.db.run",
        side_effect=[
            (None, None),
            (None, None),
            (None, [("foo", "bar")]),
            (None, None),
        ],
    )
    mocker.patch(
        "flowkit_ui_backend.impl.data_api_impl.get_indicator",
        side_effect=[ind],
    )

    config = Config(
        languages=[],
        data_providers=[dp],
        categories=[cat],
        indicators=[ind],
        spatial_resolutions=[sr],
        temporal_resolutions=[tr],
    )
    result = await maintenance_api_impl.update_setup(config, pool=provisioned_db)
    assert result is None


@pytest.mark.asyncio
async def test_update_setup_indicator_error(mocker, provisioned_db):
    mocker.patch(
        "flowkit_ui_backend.impl.maintenance_api_impl.db.delete_data",
        side_effect=[None, None],
    )
    mocker.patch(
        "flowkit_ui_backend.impl.maintenance_api_impl.db.select_data",
        side_effect=[Exception],
    )

    config = Config(
        languages=[],
        data_providers=[dp],
        categories=[cat],
        indicators=[ind],
        spatial_resolutions=[sr],
        temporal_resolutions=[tr],
    )
    with pytest.raises(HTTPException):
        await maintenance_api_impl.update_setup(config, pool=provisioned_db)


@pytest.mark.asyncio
async def test_delete_setup_error(mocker, provisioned_db):
    mocker.patch(
        "flowkit_ui_backend.impl.maintenance_api_impl.db.delete_data",
        side_effect=[None, None, None, None, None, None],
    )
    mocker.patch(
        "flowkit_ui_backend.impl.maintenance_api_impl.db.select_data",
        side_effect=[[ind], []],
    )
    mocker.patch(
        "flowkit_ui_backend.impl.maintenance_api_impl.delete_indicator",
        side_effect=[HTTPException(status_code=HTTPStatus.INTERNAL_SERVER_ERROR)],
    )

    result = await maintenance_api_impl.delete_setup(pool=provisioned_db)
    assert result is None


@pytest.mark.asyncio
async def test_delete_setup_with_indicators(mocker, provisioned_db):
    mocker.patch(
        "flowkit_ui_backend.impl.maintenance_api_impl.db.delete_data",
        side_effect=[None, None, None, None, None, None],
    )
    mocker.patch(
        "flowkit_ui_backend.impl.maintenance_api_impl.db.select_data",
        side_effect=[[ind], [ind], [cat]],
    )
    mocker.patch(
        "flowkit_ui_backend.impl.maintenance_api_impl.db.run",
        side_effect=[(None, None), (None, None)],
    )

    result = await maintenance_api_impl.delete_setup(pool=provisioned_db)
    assert result is None


@pytest.mark.asyncio
async def test_delete_setup_no_indicators(mocker, provisioned_db):
    mocker.patch(
        "flowkit_ui_backend.impl.maintenance_api_impl.db.delete_data",
        side_effect=[None, None, None, None, None],
    )
    mocker.patch(
        "flowkit_ui_backend.impl.maintenance_api_impl.db.select_data",
        side_effect=[[]],
    )

    result = await maintenance_api_impl.delete_setup(pool=provisioned_db)
    assert result is None


@pytest.mark.asyncio
async def test_create_dataset_no_data(provisioned_db):
    with pytest.raises(HTTPException):
        await maintenance_api_impl.create_dataset(
            Dataset(
                data_type="single_location",
                data_input=[],
                metadata=Metadata(
                    revision="rev",
                    category_id="foo",
                    indicator_id="foo.bar",
                    srid=1,
                    trid=1,
                ),
            ),
            pool=provisioned_db,
        )


@pytest.mark.asyncio
async def test_create_dataset_wrong_type(provisioned_db):
    with pytest.raises(HTTPException):
        await maintenance_api_impl.create_dataset(
            Dataset(
                data_type="foo",
                data_input=[DataInput(spatial_unit_ids=["foo"], data=0.01)],
                metadata=Metadata(
                    revision="rev",
                    category_id="foo",
                    indicator_id="foo.bar",
                    srid=1,
                    trid=1,
                ),
            ),
            pool=provisioned_db,
        )


@pytest.mark.asyncio
async def test_create_dataset(mocker, provisioned_db):
    mocker.patch(
        "flowkit_ui_backend.db.db.run",
        side_effect=[
            # 1
            # check dataset exists
            (None, []),
            # show create table
            (None, [("single_location_data", "CREATE TABLE...")]),
            # run create table
            (None, None),
            # 2
            # check dataset exists
            (None, [(1,)]),
        ],
    )
    mocker.patch(
        "flowkit_ui_backend.db.db.insert_data",
        side_effect=[1, None],
    )

    mocker.patch(
        "flowkit_ui_backend.impl.maintenance_api_impl.add_scope_mapping",
        side_effect=[1, 1],
    )

    content, status = await maintenance_api_impl.create_dataset(dataset=ds, pool=provisioned_db)
    assert content == 1
    assert status == HTTPStatus.CREATED

    # now it exists we run it again and it should return the existing one
    content, status = await maintenance_api_impl.create_dataset(dataset=ds, pool=provisioned_db)
    assert content == 1
    assert status == HTTPStatus.SEE_OTHER


@pytest.mark.asyncio
async def test_update_dataset(mocker, provisioned_db):
    mocker.patch(
        "flowkit_ui_backend.db.db.run",
        side_effect=[
            # 1
            # check dataset exists
            (None, []),
            # show create table
            (None, [("single_location_data", "CREATE TABLE...")]),
            # run create table
            (None, None),
            # 2
            # check dataset exists
            (None, [(1,)]),
            # get number of existing datasets
            (None, [(1,)]),
            # check dataset exists (again, in delete func)
            (None, [(1,)]),
            # delete existing dataset
            (None, None),
            # delete metadata
            (None, None),
            # delete scope mappings
            (None, None),
            # show create table
            (None, [("single_location_data", "CREATE TABLE...")]),
            # run create table
            (None, None),
        ],
    )
    mocker.patch(
        "flowkit_ui_backend.db.db.insert_data",
        side_effect=[1, None, 1, None],
    )

    mocker.patch(
        "flowkit_ui_backend.impl.maintenance_api_impl.add_scope_mapping",
        side_effect=[1, 1],
    )

    content, status = await maintenance_api_impl.update_dataset(ds, pool=provisioned_db)
    assert content == 1
    assert status == HTTPStatus.CREATED

    content, status = await maintenance_api_impl.update_dataset(ds, pool=provisioned_db)
    assert content == 1
    # status should always be CREATED because update deletes existing datasets and replaces them
    assert status == HTTPStatus.CREATED
