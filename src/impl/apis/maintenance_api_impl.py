# This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

import structlog
import json
import os
from fastapi import HTTPException
from datetime import datetime
from http import HTTPStatus
from aiomysql import Pool
from typing import Tuple, List
from dotenv import load_dotenv
from flowkit_ui_backend.models.extra_models import TokenModel
from flowkit_ui_backend.models.config import Config
from flowkit_ui_backend.models.language import Language
from flowkit_ui_backend.models.data_provider import DataProvider
from flowkit_ui_backend.models.dataset import Dataset
from flowkit_ui_backend.models.metadata import Metadata
from flowkit_ui_backend.models.single_location_data import SingleLocationData
from flowkit_ui_backend.models.flow_data import FlowData
from flowkit_ui_backend.models.category import Category
from flowkit_ui_backend.models.indicator import Indicator
from flowkit_ui_backend.models.spatial_resolution import SpatialResolution
from flowkit_ui_backend.models.temporal_resolution import TemporalResolution
from flowkit_ui_backend.models.scope_mapping import ScopeMapping
from flowkit_ui_backend.impl.util import db
from flowkit_ui_backend.impl.apis import data_api_impl


load_dotenv()

logger = structlog.get_logger("flowkit_ui_backend.log")

DB_NAME = os.getenv("DB_NAME")


async def create_data_provider(
    data_provider: DataProvider,
    pool: Pool = None,
    token_model: TokenModel = None,
) -> Tuple[DataProvider, int]:
    return await db.add_resource_with_unique_id(
        resource=data_provider, base_model=DataProvider, id_key="dpid", pool=pool
    )


async def create_category(
    category: Category, pool: Pool = None, token_model: TokenModel = None
) -> Tuple[Category, int]:
    return await db.add_resource_with_unique_id(
        resource=category, base_model=Category, id_key="category_id", pool=pool
    )


async def create_indicator(
    indicator: Indicator, pool: Pool = None, token_model: TokenModel = None
) -> Tuple[Indicator, int]:
    categories = await db.select_data(
        base_model=Category, id_key="category_id", ids=[indicator.category_id], pool=pool
    )
    if categories is None or len(categories) <= 0:
        raise HTTPException(
            status_code=HTTPStatus.NOT_FOUND,
            detail=f"Category '{indicator.category_id}' not found",
        )

    resource, status = await db.add_resource_with_unique_id(
        resource=indicator, base_model=Indicator, id_key="indicator_id", pool=pool
    )
    if status != HTTPStatus.CREATED:
        logger.debug(
            f"Indicator already exists; no need to create.", new=indicator, existing=resource
        )
        return resource, status

    return resource, status


async def create_spatial_resolution(
    spatial_resolution: SpatialResolution,
    pool: Pool = None,
    token_model: TokenModel = None,
) -> Tuple[SpatialResolution, int]:
    return await db.add_resource_with_unique_id(
        resource=spatial_resolution, base_model=SpatialResolution, id_key="srid", pool=pool
    )


async def create_temporal_resolution(
    temporal_resolution: TemporalResolution,
    pool: Pool = None,
    token_model: TokenModel = None,
) -> Tuple[TemporalResolution, int]:
    return await db.add_resource_with_unique_id(
        resource=temporal_resolution, base_model=TemporalResolution, id_key="trid", pool=pool
    )


async def update_data_provider(
    dpid: int,
    data_provider: DataProvider,
    pool: Pool = None,
    token_model: TokenModel = None,
) -> None:
    return await db.update_resource_with_unique_id(
        resource=data_provider, base_model=DataProvider, id_key="dpid", id_value=dpid, pool=pool
    )


async def update_category(
    category_id: str,
    category: Category,
    pool: Pool = None,
    token_model: TokenModel = None,
) -> None:
    return await db.update_resource_with_unique_id(
        resource=category,
        base_model=Category,
        id_key="category_id",
        id_value=category_id,
        pool=pool,
    )


async def update_indicator(
    indicator_id: str,
    indicator: Indicator,
    pool: Pool = None,
    token_model: TokenModel = None,
) -> None:
    return await db.update_resource_with_unique_id(
        resource=indicator,
        base_model=Indicator,
        id_key="indicator_id",
        id_value=indicator_id,
        pool=pool,
    )


async def update_spatial_resolution(
    srid: int,
    spatial_resolution: SpatialResolution,
    pool: Pool = None,
    token_model: TokenModel = None,
) -> None:
    return await db.update_resource_with_unique_id(
        resource=spatial_resolution,
        base_model=SpatialResolution,
        id_key="srid",
        id_value=srid,
        pool=pool,
    )


async def update_temporal_resolution(
    trid: str,
    temporal_resolution: TemporalResolution,
    pool: Pool = None,
    token_model: TokenModel = None,
) -> None:
    return await db.update_resource_with_unique_id(
        resource=temporal_resolution,
        base_model=TemporalResolution,
        id_key="trid",
        id_value=trid,
        pool=pool,
    )


async def delete_data_provider(
    dpid: int, pool: Pool = None, token_model: TokenModel = None
) -> None:
    await db.delete_data(base_model=DataProvider, id_key="dpid", ids=[dpid], pool=pool)
    return None


async def delete_category(
    category_id: str, pool: Pool = None, token_model: TokenModel = None
) -> None:
    await db.delete_data(base_model=Category, id_key="category_id", ids=[category_id], pool=pool)
    return None


async def delete_indicator(
    indicator_id: str, pool: Pool = None, token_model: TokenModel = None
) -> None:
    indicators = await db.select_data(
        base_model=Indicator, id_key="indicator_id", ids=[indicator_id], pool=pool
    )
    if indicators is None or len(indicators) <= 0:
        raise HTTPException(
            status_code=HTTPStatus.NOT_FOUND,
            detail=f"Indicator '{indicator_id}' not found",
        )

    categories = await db.select_data(
        base_model=Category, id_key="category_id", ids=[indicators[0].category_id], pool=pool
    )
    if categories in [None, []]:
        raise HTTPException(
            status_code=HTTPStatus.NOT_FOUND,
            detail=f"Category '{indicators[0].category_id}' for indicator '{indicator_id}' not found",
        )

    await db.delete_data(base_model=Indicator, id_key="indicator_id", ids=[indicator_id], pool=pool)

    base_table_name = (
        "single_location_data" if categories[0].type == "single_location" else "flow_data"
    )
    table_name = f"{base_table_name}_{indicator_id}"

    try:
        await db.run(f"TRUNCATE TABLE `{DB_NAME}`.`{table_name}`", pool=pool)
        await db.run(f"DROP TABLE `{DB_NAME}`.`{table_name}`", pool=pool)
    except Exception as e:
        raise HTTPException(
            status_code=HTTPStatus.INTERNAL_SERVER_ERROR,
            detail=f"Could not delete data table '{table_name}' for indicator '{indicator_id}': {e}",
        )

    return None


async def delete_spatial_resolution(
    srid: int, pool: Pool = None, token_model: TokenModel = None
) -> None:
    await db.delete_data(base_model=SpatialResolution, id_key="srid", ids=[srid], pool=pool)
    return None


async def delete_temporal_resolution(
    trid: int, pool: Pool = None, token_model: TokenModel = None
) -> None:
    await db.delete_data(base_model=TemporalResolution, id_key="trid", ids=[trid], pool=pool)
    return None


async def replace_setup(config: Config, pool: Pool = None, token_model: TokenModel = None) -> None:
    await delete_setup(pool=pool)
    await update_setup(config, pool=pool)
    return None


async def update_setup(config: Config, pool: Pool = None, token_model: TokenModel = None) -> None:
    # serialise the boundary data so it can go into the db
    spatial_resolutions = []
    for sr in config.spatial_resolutions:
        sr_new = sr
        sr_new.boundaries = json.dumps(sr.boundaries)
        spatial_resolutions.append(sr_new)
    # delete data where ID is given
    lids = [l.lid for l in config.languages if l.lid]
    dpids = [dp.dpid for dp in config.data_providers if dp.dpid]
    categories = [c.category_id for c in config.categories if c.category_id]
    indicators = [i.indicator_id for i in config.indicators if i.indicator_id]
    srids = [sr.srid for sr in config.spatial_resolutions if sr.srid]
    trids = [tr.trid for tr in config.temporal_resolutions if tr.trid]
    await db.delete_data(base_model=Language, id_key="lid", ids=lids, pool=pool)
    await db.delete_data(base_model=DataProvider, id_key="dpid", ids=dpids, pool=pool)

    # special case Indicator: need to delete data tables
    for indicator_id in indicators:
        try:
            indicator = await data_api_impl.get_indicator(indicator_id, pool=pool)
            if indicator is not None:
                await delete_indicator(indicator_id, pool=pool)
        except HTTPException as e:
            # swallowing exception here. If no indicator exists, we don't need to delete
            pass
        except Exception as e:
            raise HTTPException(
                status_code=HTTPStatus.INTERNAL_SERVER_ERROR,
                detail="Failed to delete existing indicator",
            )

    await db.delete_data(base_model=Category, id_key="category_id", ids=categories, pool=pool)
    await db.delete_data(base_model=SpatialResolution, id_key="srid", ids=srids, pool=pool)
    await db.delete_data(base_model=TemporalResolution, id_key="trid", ids=trids, pool=pool)
    # add all data
    await db.insert_data(base_model=Language, id_key="lid", data=config.languages, pool=pool)
    await db.insert_data(
        base_model=DataProvider, id_key="dpid", data=config.data_providers, pool=pool
    )
    await db.insert_data(
        base_model=Category, id_key="category_id", data=config.categories, pool=pool
    )

    # special case Indicator: need to create data tables
    for indicator in config.indicators:
        await create_indicator(indicator, pool=pool)

    await db.insert_data(
        base_model=SpatialResolution, id_key="srid", data=spatial_resolutions, pool=pool
    )
    await db.insert_data(
        base_model=TemporalResolution, id_key="trid", data=config.temporal_resolutions, pool=pool
    )
    return None


async def delete_setup(pool: Pool = None, token_model: TokenModel = None) -> None:
    await db.delete_data(base_model=Language, pool=pool)
    await db.delete_data(base_model=DataProvider, pool=pool)

    # special case Indicator: need to delete data tables
    indicators = await data_api_impl.list_indicators(pool=pool)
    logger.debug("after list indicators", indicators=indicators)
    for indicator in indicators.indicators:
        try:
            logger.debug(indicator)
            if indicator is not None:
                result = await delete_indicator(indicator.indicator_id, pool=pool)
                logger.debug("after delete indicator", result=result)
        except HTTPException as e:
            logger.debug("in catch", e=e)
            # swallowing exception here. If no indicator exists, we don't need to delete
            pass
    logger.debug("after loop")

    await db.delete_data(base_model=Category, pool=pool)
    await db.delete_data(base_model=SpatialResolution, pool=pool)
    await db.delete_data(base_model=TemporalResolution, pool=pool)
    logger.debug("before return")
    return None


async def create_dataset(
    dataset: Dataset, pool: Pool = None, token_model: TokenModel = None
) -> Tuple[None, int]:
    return await add_dataset(dataset, overwrite=False, pool=pool)


async def update_dataset(
    dataset: Dataset, pool: Pool = None, token_model: TokenModel = None
) -> Tuple[None, int]:
    return await add_dataset(dataset, overwrite=True, pool=pool)


async def check_dataset_exists(
    dataset: Dataset, pool: Pool = None, token_model: TokenModel = None
) -> List[str]:
    sql = f"""
    SELECT md.mdid FROM `{DB_NAME}`.`metadata` AS md
    WHERE md.`category_id`=%(category_id)s
    AND md.`indicator_id`=%(indicator_id)s
    AND md.srid=%(srid)s
    AND md.trid=%(trid)s
    AND md.dt=%(dt)s
    """
    props = {
        "category_id": dataset.metadata.category_id,
        "indicator_id": dataset.metadata.indicator_id,
        "srid": dataset.metadata.srid,
        "trid": dataset.metadata.trid,
        "dt": dataset.metadata.dt,
    }
    (column_names, result) = await db.run(sql, props, pool=pool)
    if result is not None and len(result) > 0:
        logger.debug(f"Found existing dataset{'' if len(result)==1 else 's'}", num=len(result))

    return [str(row[0]) for row in result]


async def delete_dataset(
    dataset: Dataset, pool: Pool = None, token_model: TokenModel = None
) -> None:
    mdids = await check_dataset_exists(dataset, pool=pool)
    if len(mdids) > 0:
        existing_mdids = ",".join(mdids)
        logger.debug(f"Deleting existing dataset{'' if len(mdids)==1 else 's'}", mdids=mdids)

        # make sure to amend table name for data tables
        base_table_name = (
            "single_location_data" if dataset.data_type == "single_location" else "flow_data"
        )
        table_name = f"{base_table_name}_{dataset.metadata.indicator_id}"
        logger.debug(
            "Using indicator-specific data table",
            base_table_name=base_table_name,
            table_name=table_name,
        )

        # check if data table exists
        sql = f"""
        SELECT COUNT(*) AS num
        FROM information_schema.tables
        WHERE table_schema = '{DB_NAME}'
        AND table_name = '{table_name}'
        """
        (column_names, result) = await db.run(sql=sql, pool=pool)

        if result[0][0] > 0:
            sql = f"""
            DELETE FROM `{DB_NAME}`.`{table_name}`
            WHERE `mdid` IN ({existing_mdids})
            """
            await db.run(sql=sql, pool=pool)

        sql = f"""
        DELETE FROM `{DB_NAME}`.`metadata`
        WHERE `mdid` IN ({existing_mdids})
        """
        await db.run(sql=sql, pool=pool)


async def add_dataset(
    dataset: Dataset,
    overwrite: bool = False,
    pool: Pool = None,
    token_model: TokenModel = None,
) -> Tuple[None, int]:
    if dataset.data_input is None or len(dataset.data_input) <= 0:
        raise HTTPException(status_code=HTTPStatus.BAD_REQUEST, detail="No data to ingest")

    if dataset.data_type not in ["single_location", "flow"]:
        raise HTTPException(
            status_code=HTTPStatus.BAD_REQUEST,
            detail=f'Unknown data type "{dataset.data_type}"',
        )

    return_status_code = HTTPStatus.NO_CONTENT
    mdids = await check_dataset_exists(dataset, pool=pool)
    if len(mdids) > 0:
        if overwrite:
            await delete_dataset(dataset, pool=pool)
            return_status_code = HTTPStatus.CREATED
        else:
            return None, HTTPStatus.NO_CONTENT
    else:
        return_status_code = HTTPStatus.CREATED

    dataset.metadata.min_value = min([di.data for di in dataset.data_input])
    dataset.metadata.max_value = max([di.data for di in dataset.data_input])
    dataset.metadata.date_added = datetime.utcnow().strftime("%Y-%m-%dT%H:%M:%S")

    # since we're only adding a single metadata object here, mdid will be set
    mdid = await db.insert_data(
        base_model=Metadata, id_key="mdid", data=[dataset.metadata], pool=pool
    )

    logger.debug(f"Converting data to appropriate data type...", data_type=dataset.data_type)
    data_func = (
        lambda input_data: SingleLocationData(
            mdid=mdid, spatial_unit_id=input_data.spatial_unit_ids[0], data=input_data.data
        )
        if dataset.data_type == "single_location"
        else FlowData(
            mdid=mdid,
            origin=input_data.spatial_unit_ids[0],
            destination=input_data.spatial_unit_ids[1],
            data=input_data.data,
        )
    )
    data_input = [data_func(input_row) for input_row in dataset.data_input]

    # make sure to amend table name for data tables
    base_table_name = data_input[0].__module__.split(".")[-1]
    table_name = f"{base_table_name}_{dataset.metadata.indicator_id}_{mdid}"
    logger.debug(
        "Using indicator-specific data table",
        base_table_name=base_table_name,
        table_name=table_name,
    )

    # Get table template from db and adapt. This includes the partitioning which was added during the provisioning.
    (column_names, result) = await db.run(
        f"SHOW CREATE TABLE {DB_NAME}.`{base_table_name}`;",
        pool=pool,
    )
    if result is None:
        raise HTTPException(
            status_code=HTTPStatus.INTERNAL_SERVER_ERROR,
            detail=f"Could not find base table `{base_table_name}`",
        )
    sql = result[0][1]
    sql = sql.replace(f"`{base_table_name}`", f"`{table_name}`")

    # create dedicated table
    try:
        await db.run(sql, pool=pool)
    except Exception as e:
        raise HTTPException(
            status_code=HTTPStatus.INTERNAL_SERVER_ERROR,
            detail=f"Could not create data table for indicator: {e}",
        )

    logger.debug(f"Inserting data...")
    await db.insert_data(
        base_model=type(data_input[0]),
        data=data_input,
        bulk=True,
        table_name_override=table_name,
        pool=pool,
    )

    return None, return_status_code


async def check_scope_mapping_exists(
    scope_mapping: ScopeMapping,
    pool: Pool = None,
    token_model: TokenModel = None,
) -> List[str]:
    sql = f"""
    SELECT sm.id FROM `{DB_NAME}`.`scope_mapping` AS sm
    WHERE sm.`scope`=%(scope)s
    AND sm.`mdid`=%(mdid)s
    """
    props = {"scope": scope_mapping.scope, "mdid": scope_mapping.mdid}
    (column_names, result) = await db.run(sql, props, pool=pool)
    if result is not None and len(result) > 0:
        logger.debug(
            f"Found existing scope mapping{'' if len(result)==1 else 's'}", num=len(result)
        )

    return [str(row[0]) for row in result]


async def add_scope_mapping(
    scope_mapping: ScopeMapping,
    overwrite: bool = False,
    pool: Pool = None,
    token_model: TokenModel = None,
) -> None:

    if scope_mapping is None or scope_mapping.scope is None or scope_mapping.mdid is None:
        raise HTTPException(
            status_code=HTTPStatus.BAD_REQUEST, detail=f"Scope mapping {scope_mapping} is invalid"
        )

    return_status_code = HTTPStatus.NO_CONTENT
    scope_mappings = await check_scope_mapping_exists(scope_mapping, pool=pool)
    if len(scope_mappings) > 0:
        if overwrite:
            await delete_scope_mapping(scope_mappings, pool=pool)
            return_status_code = HTTPStatus.CREATED
        else:
            return None, HTTPStatus.NO_CONTENT
    else:
        return_status_code = HTTPStatus.CREATED

    await db.insert_data(
        base_model=ScopeMapping,
        data=[scope_mapping],
        bulk=False,
        pool=pool,
    )

    return None, return_status_code


async def delete_scope_mapping(
    scope_mapping: ScopeMapping,
    pool: Pool = None,
    token_model: TokenModel = None,
) -> None:
    ids = await check_scope_mapping_exists(scope_mapping, pool=pool)
    if len(ids) > 0:
        existing_ids = ",".join(ids)
        logger.debug(f"Deleting existing dataset{'' if len(ids)==1 else 's'}", ids=ids)

        sql = f"""
        DELETE FROM `{DB_NAME}`.`scope_mapping`
        WHERE `id` IN ({existing_ids})
        """
        await db.run(sql=sql, pool=pool)
