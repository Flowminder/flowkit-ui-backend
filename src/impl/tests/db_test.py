# This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

import pytest
import asyncio
import aiomysql
import os
from http import HTTPStatus
from fastapi import HTTPException
from unittest.mock import MagicMock
from decimal import Decimal
from flowkit_ui_backend.impl.util import db
from flowkit_ui_backend.models.data_provider import DataProvider
from flowkit_ui_backend.models.language import Language


dp = DataProvider(dpid=1, name="foo")
languages = [
    Language(lid=1, code="FO", name="Foo", flag="foo.svg", default=True),
    Language(lid=2, code="BA", name="Bar", flag="bar.svg", default=False),
    Language(lid=2, code="BZ", name="Baz", flag="baz.svg", default=False),
]


# helper function to get a pool without an app
async def get_pool():
    return await aiomysql.create_pool(
        host=os.getenv("CONTAINER_NAME_DB"),
        port=int(os.getenv("DB_PORT_CONTAINER")),
        user=os.getenv("DB_USER"),
        password=os.getenv("DB_PW"),
        db=os.getenv("DB_NAME"),
        loop=asyncio.get_event_loop(),
        autocommit=True,
        local_infile=True,
    )


# TODO: struggling with mocking async mysql connection
def get_mock_pool():
    mock_cursor = MagicMock()
    mock_cursor.description = None
    f3 = asyncio.Future()
    f3.set_result("foo")
    mock_cursor.fetchall.return_value = f3
    mock_cnx = MagicMock()
    f2 = asyncio.Future()
    f2.set_result(mock_cursor)
    mock_cnx.cursor.return_value = f2
    mock_cnx.__aenter__.return_value = mock_cnx
    mock_pool = MagicMock()
    f1 = asyncio.Future()
    f1.set_result(mock_cnx)
    mock_pool.acquire.return_value = f1
    mock_pool.__aenter__.return_value = mock_pool

    return mock_pool


@pytest.mark.asyncio
async def test_provision_db_subsequent_run(mocker):
    mocker.patch(
        "flowkit_ui_backend.impl.util.db.os.path.isfile",
        side_effect=[True],
    )

    result = await db.provision_db(pool=await get_pool())
    assert result is False


@pytest.mark.asyncio
async def test_provision_db(mocker):
    mocker.patch(
        "flowkit_ui_backend.impl.util.db.os.path.isfile",
        side_effect=[False],
    )

    await db.provision_db(pool=await get_pool())
    # TODO: add meaningful tests


@pytest.mark.asyncio
async def test_provision_db_force_setup(mocker):
    mocker.patch(
        "flowkit_ui_backend.impl.util.db.os.path.isfile",
        side_effect=[False],
    )

    os.environ["FORCE_DB_SETUP"] = "1"
    await db.provision_db(pool=await get_pool())
    # TODO: add meaningful tests


@pytest.mark.asyncio
async def test_get_index(mocker):
    mocker.patch(
        "flowkit_ui_backend.impl.util.db.run",
        side_effect=[(None, [(1, "metadata", "index_metadata_dt")]), (None, []), (None, None)],
    )

    # field has index
    index_name = await db.get_index("metadata", "dt", pool=await get_pool())
    assert index_name == "index_metadata_dt"
    # field doesn't have index
    index_name = await db.get_index("metadata", "revision", pool=await get_pool())
    assert index_name is None
    # field doesn't exist
    index_name = await db.get_index("metadata", "foo", pool=await get_pool())
    assert index_name is None
    # table doesn't exist
    with pytest.raises(Exception):
        index_name = await db.get_index("foo", "dt", pool=await get_pool())


@pytest.mark.asyncio
async def test_add_index(mocker):

    mocker.patch(
        "flowkit_ui_backend.impl.util.db.run",
        side_effect=[Exception("Index exists"), None, Exception("Table doesn't exist")],
    )

    # index already exists
    with pytest.raises(Exception):
        index_name = await db.add_index("metadata", "dt", pool=await get_pool())
    # index doesn't exist
    index_name = await db.add_index("metadata", "mdid", pool=await get_pool())
    assert index_name == "index_metadata_mdid"
    # table doesn't exist
    with pytest.raises(Exception):
        index_name = await db.add_index("foo", "mdid", pool=await get_pool())


@pytest.mark.asyncio
async def test_drop_index(mocker):

    mocker.patch(
        "flowkit_ui_backend.impl.util.db.run",
        side_effect=[None, Exception("Index doesn't exist"), Exception("Table doesn't exist")],
    )

    # index exists
    await db.drop_index("metadata", "dt", pool=await get_pool())
    # index doesn't exist
    with pytest.raises(Exception):
        await db.drop_index("metadata", "foo", pool=await get_pool())
    # table doesn't exist
    with pytest.raises(Exception):
        await db.drop_index("foo", "dt", pool=await get_pool())


@pytest.mark.asyncio
async def test_add_indices(mocker):
    mocker.patch(
        "flowkit_ui_backend.impl.util.db.run",
        side_effect=[None, None, None],
    )
    mocker.patch(
        "flowkit_ui_backend.impl.util.db.get_index",
        side_effect=[None, None, None],
    )

    await db.add_indices(pool=await get_pool())
    # TODO: add meaningful tests


@pytest.mark.asyncio
async def test_add_indices_wrong_category_type(mocker):
    mocker.patch(
        "flowkit_ui_backend.impl.util.db.run",
        side_effect=[(None, None), (None, None), (None, None)],
    )

    await db.add_indices(category_type="foo", pool=await get_pool())
    # TODO: add meaningful tests


@pytest.mark.asyncio
async def test_drop_indices_none(mocker):
    mocker.patch(
        "flowkit_ui_backend.impl.util.db.run",
        side_effect=[(None, None), (None, None), (None, None)],
    )

    await db.drop_indices(pool=await get_pool())
    # TODO: add meaningful tests


@pytest.mark.asyncio
async def test_drop_indices(mocker):
    mocker.patch(
        "flowkit_ui_backend.impl.util.db.get_index",
        side_effect=["baz", None, None],
    )
    mocker.patch(
        "flowkit_ui_backend.impl.util.db.run",
        side_effect=[(None, None)],
    )

    await db.drop_indices(category_type="single_location", pool=await get_pool())
    # TODO: add meaningful tests


@pytest.mark.asyncio
async def test_drop_indices_wrong_category_type(mocker):
    mocker.patch(
        "flowkit_ui_backend.impl.util.db.run",
        side_effect=[(None, None), (None, None), (None, None)],
    )

    await db.drop_indices(category_type="foo", pool=await get_pool())
    # TODO: add meaningful tests


@pytest.mark.asyncio
async def test_load_prepared_sql():
    assert (await db.load_prepared_sql(DataProvider, "SELECT")).startswith("SELECT")
    assert (await db.load_prepared_sql(DataProvider, "DELETE")).startswith("DELETE")
    assert (await db.load_prepared_sql(DataProvider, "UPDATE")).startswith("UPDATE")
    assert (await db.load_prepared_sql(DataProvider, "INSERT")).startswith("INSERT")


@pytest.mark.asyncio
async def test_run():
    await db.run("SHOW VARIABLES", pool=await get_pool())
    # TODO: add meaningful tests


@pytest.mark.asyncio
async def test_run_script():
    await db.run_script("/this/script/doesnt/exist", pool=await get_pool())
    await db.run_script("/path/to/script", pool=await get_pool())
    # TODO: add meaningful tests


@pytest.mark.asyncio
async def test_select_data():
    # await db.select_data(base_model=TemporalResolution, pool=get_mock_pool())
    pass
    # TODO: add meaningful tests


@pytest.mark.asyncio
async def test_select_data_subset():
    # await db.select_data(
    #    base_model=TemporalResolution, id_key="trid", ids=[1], pool=get_mock_pool()
    # )
    pass
    # TODO: add meaningful tests


@pytest.mark.asyncio
async def test_select_data_specify_fields():
    # await db.select_data(
    #    base_model=TemporalResolution, fields=["trid", "index"], pool=get_mock_pool()
    # )
    pass
    # TODO: add meaningful tests


@pytest.mark.asyncio
async def test_select_data_table_name_override():
    # await db.select_data(
    #    base_model=FlowData, table_name_override="flow_data", pool=get_mock_pool()
    # )
    pass
    # TODO: add meaningful tests


@pytest.mark.asyncio
async def test_select_data_deserialise_field(mocker):
    mock_cnx = MagicMock()
    mock_cursor = MagicMock()
    mock_cursor.description = [
        ("id",),
        ("indicator_id",),
        ("category_id",),
        ("order",),
        ("label",),
        ("description",),
        ("method",),
        ("scale",),
        ("decimals",),
        ("min_value",),
        ("max_value",),
        ("num_bins",),
        ("bins",),
        ("translation",),
    ]
    mock_cursor.fetchall.return_value = [
        (
            12,
            "relocations.abnormality",
            "relocations",
            4,
            "Abnormality",
            "desc",
            "meth",
            "diverging",
            2,
            Decimal("-6.000000000"),
            Decimal("6.000000000"),
            None,
            '[{"max": 3, "min": -3, "width": "2%"}, {"max": -3, "min": -6, "width": "20%"}, {"max": 6, "min": 3, "width": "20%"}, {"max": -6, "min": null, "width": "80%"}, {"max": null, "min": 6, "width": "80%"}]',
            '{"fr": {"label": "Anomalie des changements de r\\u00e9sidence", "description": "..."}}',
        )
    ]
    mock_cnx.cursor.return_value = mock_cursor

    # TODO: mock out the db cursor so it returns what we want
    # await db.select_data(base_model=Indicator, pool=get_mock_pool())
    # TODO: add meaningful tests


@pytest.mark.asyncio
async def test_insert_data_empty():
    # await db.insert_data(base_model=DataProvider, id_key="dpid", data=[], pool=get_mock_pool())
    pass
    # TODO: add meaningful tests


@pytest.mark.asyncio
async def test_insert_data():
    # await db.insert_data(
    #    base_model=DataProvider,
    #    id_key="dpid",
    #    data=[DataProvider(name="foo"), DataProvider(name="bar")],
    #    pool=get_mock_pool(),
    # )
    pass
    # TODO: add meaningful tests


@pytest.mark.asyncio
async def test_update_data_no_id_key():
    with pytest.raises(Exception):
        await db.update_data(base_model=DataProvider, id_key=None, pool=await get_pool())


@pytest.mark.asyncio
async def test_update_data():
    # await db.update_data(
    #    base_model=DataProvider,
    #    id_key="dpid",
    #    id_value=1,
    #    resource=DataProvider(name="foo"),
    #    pool=get_mock_pool(),
    # )
    pass
    # TODO: add meaningful tests


@pytest.mark.asyncio
async def test_delete_data():
    # await db.delete_data(base_model=TemporalResolution, pool=get_mock_pool())
    # await db.delete_data(
    #    base_model=TemporalResolution, id_key="trid", ids=[], pool=get_mock_pool()
    # )
    pass
    # TODO: add meaningful tests


@pytest.mark.asyncio
async def test_add_resource_with_unique_id_error(mocker):
    mocker.patch(
        "flowkit_ui_backend.impl.util.db.select_data",
        side_effect=[HTTPException(HTTPStatus.INTERNAL_SERVER_ERROR)],
    )

    with pytest.raises(HTTPException):
        await db.add_resource_with_unique_id(
            resource=dp, base_model=DataProvider, id_key="dpid", pool=await get_pool()
        )


@pytest.mark.asyncio
async def test_add_resource_with_unique_id_existing(mocker):
    mocker.patch(
        "flowkit_ui_backend.impl.util.db.select_data",
        side_effect=[[dp]],
    )

    existing_resource, status_code = await db.add_resource_with_unique_id(
        resource=dp, base_model=DataProvider, id_key="dpid", pool=await get_pool()
    )
    assert status_code == HTTPStatus.SEE_OTHER
    assert existing_resource == dp


@pytest.mark.asyncio
async def test_add_resource_with_unique_id_inexistent_created(mocker):
    mocker.patch(
        "flowkit_ui_backend.impl.util.db.select_data",
        side_effect=[[], [dp]],
    )
    mocker.patch(
        "flowkit_ui_backend.impl.util.db.insert_data",
        side_effect=[None],
    )

    new_resource, status_code = await db.add_resource_with_unique_id(
        resource=dp, base_model=DataProvider, id_key="dpid", pool=await get_pool()
    )
    assert status_code == HTTPStatus.CREATED
    assert new_resource == dp


@pytest.mark.asyncio
async def test_add_resource_with_unique_id_not_found_created(mocker):
    mocker.patch(
        "flowkit_ui_backend.impl.util.db.select_data",
        side_effect=[HTTPException(HTTPStatus.NOT_FOUND, "foo"), [dp]],
    )
    mocker.patch(
        "flowkit_ui_backend.impl.util.db.insert_data",
        side_effect=[None],
    )

    new_resource, status_code = await db.add_resource_with_unique_id(
        resource=dp, base_model=DataProvider, id_key="dpid", pool=await get_pool()
    )
    assert status_code == HTTPStatus.CREATED
    assert new_resource == dp


@pytest.mark.asyncio
async def test_update_resource_with_unique_id_inexistent(mocker):
    mocker.patch(
        "flowkit_ui_backend.impl.util.db.select_data",
        side_effect=[[]],
    )

    with pytest.raises(HTTPException):
        await db.update_resource_with_unique_id(
            resource=dp, base_model=DataProvider, id_key="dpid", id_value=1, pool=await get_pool()
        )


@pytest.mark.asyncio
async def test_update_resource_with_unique_id_change_id():
    with pytest.raises(HTTPException):
        await db.update_resource_with_unique_id(
            resource=dp, base_model=DataProvider, id_key="dpid", id_value=2, pool=await get_pool()
        )


@pytest.mark.asyncio
async def test_update_resource_with_unique_id_error(mocker):
    mocker.patch(
        "flowkit_ui_backend.impl.util.db.select_data",
        side_effect=[[dp]],
    )
    mocker.patch(
        "flowkit_ui_backend.impl.util.db.update_data",
        side_effect=[Exception],
    )

    with pytest.raises(HTTPException):
        await db.update_resource_with_unique_id(
            resource=dp, base_model=DataProvider, id_key="dpid", id_value=2, pool=await get_pool()
        )


@pytest.mark.asyncio
async def test_update_resource_with_unique_id_success(mocker):
    mocker.patch(
        "flowkit_ui_backend.impl.util.db.select_data",
        side_effect=[[dp]],
    )
    mocker.patch(
        "flowkit_ui_backend.impl.util.db.update_data",
        side_effect=[None],
    )

    result = await db.update_resource_with_unique_id(
        resource=dp, base_model=DataProvider, id_key="dpid", id_value=1, pool=await get_pool()
    )
    assert result is None
