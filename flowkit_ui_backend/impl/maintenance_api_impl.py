# This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

import structlog
import json
import os
from fastapi import HTTPException
from datetime import datetime
from http import HTTPStatus
from aiomysql import Pool
from typing import Tuple
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
from flowkit_ui_backend.db import db
from flowkit_ui_backend.impl import data_api_impl


logger = structlog.get_logger("flowkit_ui_backend.log")


async def create_data_provider(
    data_provider: DataProvider,
    pool: Pool,
    token_model: TokenModel = None,
) -> Tuple[DataProvider, int]:
    return await db.add_resource_with_unique_id(
        resource=data_provider, base_model=DataProvider, id_key="dpid", pool=pool
    )


async def create_category(
    category: Category, pool: Pool, token_model: TokenModel = None
) -> Tuple[Category, int]:
    return await db.add_resource_with_unique_id(
        resource=category, base_model=Category, id_key="category_id", pool=pool
    )


async def create_indicator(
    indicator: Indicator, pool: Pool, token_model: TokenModel = None
) -> Tuple[Indicator, int]:
    categories = await db.select_data(
        base_model=Category,
        pool=pool,
        id_key="category_id",
        ids=[indicator.category_id],
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
            f"Indicator already exists; no need to create.",
            new=indicator,
            existing=resource,
        )
        return resource, status

    return resource, status


async def create_spatial_resolution(
    spatial_resolution: SpatialResolution,
    pool: Pool,
    token_model: TokenModel = None,
) -> Tuple[SpatialResolution, int]:
    return await db.add_resource_with_unique_id(
        resource=spatial_resolution,
        base_model=SpatialResolution,
        id_key="srid",
        pool=pool,
    )


async def create_temporal_resolution(
    temporal_resolution: TemporalResolution,
    pool: Pool,
    token_model: TokenModel = None,
) -> Tuple[TemporalResolution, int]:
    return await db.add_resource_with_unique_id(
        resource=temporal_resolution,
        base_model=TemporalResolution,
        id_key="trid",
        pool=pool,
    )


async def update_data_provider(
    dpid: int,
    data_provider: DataProvider,
    pool: Pool,
    token_model: TokenModel = None,
) -> None:
    return await db.update_resource_with_unique_id(
        resource=data_provider,
        base_model=DataProvider,
        id_key="dpid",
        id_value=dpid,
        pool=pool,
    )


async def update_category(
    category_id: str,
    category: Category,
    pool: Pool,
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
    pool: Pool,
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
    pool: Pool,
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
    pool: Pool,
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
    dpid: int, pool: Pool, token_model: TokenModel = None
) -> None:
    await db.delete_data(base_model=DataProvider, pool=pool, ids=[dpid], id_key="dpid")
    return None


async def delete_category(
    category_id: str, pool: Pool, token_model: TokenModel = None
) -> None:
    await db.delete_data(
        base_model=Category, pool=pool, ids=[category_id], id_key="category_id"
    )
    return None


async def delete_indicator(
    indicator_id: str, pool: Pool, token_model: TokenModel = None
) -> None:
    indicators = await db.select_data(
        base_model=Indicator, pool=pool, id_key="indicator_id", ids=[indicator_id]
    )
    if indicators is None or len(indicators) <= 0:
        raise HTTPException(
            status_code=HTTPStatus.NOT_FOUND,
            detail=f"Indicator '{indicator_id}' not found",
        )

    await db.delete_data(
        base_model=Indicator, pool=pool, ids=[indicator_id], id_key="indicator_id"
    )

    return None


async def delete_spatial_resolution(
    srid: int, pool: Pool, token_model: TokenModel = None
) -> None:
    await db.delete_data(
        base_model=SpatialResolution, pool=pool, ids=[srid], id_key="srid"
    )
    return None


async def delete_temporal_resolution(
    trid: int, pool: Pool, token_model: TokenModel = None
) -> None:
    await db.delete_data(
        base_model=TemporalResolution, pool=pool, ids=[trid], id_key="trid"
    )
    return None


async def replace_setup(
    config: Config, pool: Pool, token_model: TokenModel = None
) -> None:
    await delete_setup(
        pool=pool,
    )
    await update_setup(
        config,
        pool=pool,
    )
    return None


async def update_setup(
    config: Config, pool: Pool, token_model: TokenModel = None
) -> None:
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
    await db.delete_data(base_model=Language, pool=pool, ids=lids, id_key="lid")
    await db.delete_data(base_model=DataProvider, pool=pool, ids=dpids, id_key="dpid")

    # special case Indicator: need to delete data tables
    for indicator_id in indicators:
        try:
            indicator = await data_api_impl.get_indicator(
                indicator_id, pool=pool, token_model=None
            )
            if indicator is not None:
                await delete_indicator(
                    indicator_id,
                    pool=pool,
                )
        except HTTPException as e:
            # swallowing exception here. If no indicator exists, we don't need to delete
            pass
        except Exception as e:
            raise HTTPException(
                status_code=HTTPStatus.INTERNAL_SERVER_ERROR,
                detail="Failed to delete existing indicator",
            )

    await db.delete_data(
        base_model=Category, pool=pool, ids=categories, id_key="category_id"
    )
    await db.delete_data(
        base_model=SpatialResolution, pool=pool, ids=srids, id_key="srid"
    )
    await db.delete_data(
        base_model=TemporalResolution, pool=pool, ids=trids, id_key="trid"
    )
    # add all data
    await db.insert_data(
        base_model=Language, pool=pool, id_key="lid", data=config.languages
    )
    await db.insert_data(
        base_model=DataProvider, pool=pool, id_key="dpid", data=config.data_providers
    )
    await db.insert_data(
        base_model=Category, pool=pool, id_key="category_id", data=config.categories
    )

    # special case Indicator: need to create data tables
    for indicator in config.indicators:
        await create_indicator(indicator, pool=pool)

    await db.insert_data(
        base_model=SpatialResolution, pool=pool, id_key="srid", data=spatial_resolutions
    )
    await db.insert_data(
        base_model=TemporalResolution,
        pool=pool,
        id_key="trid",
        data=config.temporal_resolutions,
    )
    return None


async def delete_setup(pool: Pool, token_model: TokenModel = None) -> None:
    await db.delete_data(base_model=Language, pool=pool)
    await db.delete_data(base_model=DataProvider, pool=pool)

    # special case Indicator: need to delete data tables
    indicators = await data_api_impl.list_indicators(pool=pool, token_model=None)
    logger.debug("after list indicators", indicators=indicators)
    for indicator in indicators.indicators:
        try:
            logger.debug(indicator)
            if indicator is not None:
                result = await delete_indicator(
                    indicator.indicator_id,
                    pool=pool,
                )
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
    dataset: Dataset, pool: Pool, token_model: TokenModel = None
) -> Tuple[int, int]:
    return await add_dataset(dataset, pool=pool, overwrite=False)


async def update_dataset(
    dataset: Dataset, pool: Pool, token_model: TokenModel = None
) -> Tuple[int, int]:
    return await add_dataset(dataset, pool=pool, overwrite=True)


async def check_dataset_exists(
    dataset: Dataset, pool: Pool, token_model: TokenModel = None
) -> int:
    """

    Parameters
    ----------
    dataset
    pool
    token_model

    Returns
    -------
    int
        Either the mdid of the dataset if it exists, or -1 if no matching dataset
        could be found.
    """
    sql = f"""
    SELECT md.mdid FROM `metadata` AS md
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
    (column_names, result) = await db.run(pool=pool, sql=sql, args=props)
    if result is not None and len(result) == 1:
        logger.debug(f"Found existing dataset.")
    elif result is not None and len(result) > 1:
        logger.error(
            "Multiple ids for dataset.", ids=[res[0] for res in result], props=props
        )
        raise HTTPException(
            status_code=HTTPStatus.INTERNAL_SERVER_ERROR, detail="Ambiguous dataset"
        )
    else:
        return -1
    return result[0][0]


async def delete_dataset(
    dataset: Dataset, pool: Pool, token_model: TokenModel = None
) -> None:
    mdid = await check_dataset_exists(
        dataset,
        pool=pool,
    )
    if mdid != -1:
        logger.debug(f"Deleting existing dataset", mdids=mdid)

        # make sure to amend table name for data tables
        base_table_name = (
            "single_location_data"
            if dataset.data_type == "single_location"
            else "flow_data"
        )
        table_name = f"{base_table_name}_{dataset.metadata.indicator_id}_{mdid}"
        logger.debug(
            "Using indicator-specific data table",
            base_table_name=base_table_name,
            table_name=table_name,
        )

        # drop the data table if it exists

        sql = f"""
        DROP TABLE IF EXISTS `{table_name}`
        """
        await db.run(sql=sql, pool=pool)
        logger.debug(
            "Deleting metadata",
            mdid=mdid,
        )
        sql = f"""
        DELETE FROM `metadata`
        WHERE `mdid`={mdid}
        """
        await db.run(pool=pool, sql=sql)
        logger.debug(
            "Deleting scope mappings",
            mdid=mdid,
        )
        # Cleanup scope mappings
        sql = f"""
        DELETE FROM `scope_mapping`
        WHERE `mdid`={mdid}
        """
        await db.run(pool=pool, sql=sql)


async def add_dataset(
    dataset: Dataset,
    pool: Pool,
    overwrite: bool = False,
    token_model: TokenModel = None,
) -> Tuple[int, int]:
    if dataset.data_input is None or len(dataset.data_input) <= 0:
        raise HTTPException(
            status_code=HTTPStatus.BAD_REQUEST, detail="No data to ingest"
        )

    if dataset.data_type not in ["single_location", "flow"]:
        raise HTTPException(
            status_code=HTTPStatus.BAD_REQUEST,
            detail=f'Unknown data type "{dataset.data_type}"',
        )

    mdid = await check_dataset_exists(
        dataset,
        pool=pool,
    )
    if mdid != -1:
        if overwrite:
            await delete_dataset(dataset, pool=pool)
            return_status_code = HTTPStatus.CREATED
        else:
            return mdid, HTTPStatus.SEE_OTHER
    else:
        return_status_code = HTTPStatus.CREATED

    dataset.metadata.min_value = min([di.data for di in dataset.data_input])
    dataset.metadata.max_value = max([di.data for di in dataset.data_input])
    dataset.metadata.date_added = datetime.utcnow().strftime("%Y-%m-%dT%H:%M:%S")

    # since we're only adding a single metadata object here, mdid will be set
    mdid = await db.insert_data(
        base_model=Metadata, pool=pool, id_key="mdid", data=[dataset.metadata]
    )

    logger.debug(
        f"Converting data to appropriate data type...", data_type=dataset.data_type
    )
    data_func = lambda input_data: (
        SingleLocationData(
            mdid=mdid,
            spatial_unit_id=input_data.spatial_unit_ids[0],
            data=input_data.data,
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
        pool=pool,
        sql=f"SHOW CREATE TABLE `{base_table_name}`;",
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
        await db.run(pool=pool, sql=sql)
    except Exception as e:
        raise HTTPException(
            status_code=HTTPStatus.INTERNAL_SERVER_ERROR,
            detail=f"Could not create data table for indicator: {e}",
        )

    logger.debug(f"Inserting data...")
    await db.insert_data(
        base_model=type(data_input[0]),
        pool=pool,
        data=data_input,
        bulk=True,
        table_name_override=table_name,
    )
    # TODO: this should really be more like 'for each default scope mapping in the provided config'
    await add_scope_mapping(
        ScopeMapping(mdid=mdid, scope="admin"), pool=pool, token_model=token_model
    )
    return mdid, return_status_code


async def check_scope_mapping_exists(
    scope_mapping: ScopeMapping,
    pool: Pool,
    token_model: TokenModel = None,
) -> int:
    sql = f"""
    SELECT sm.id FROM `scope_mapping` AS sm
    WHERE sm.`scope`=%(scope)s
    AND sm.`mdid`=%(mdid)s
    """
    props = {"scope": scope_mapping.scope, "mdid": scope_mapping.mdid}
    (column_names, result) = await db.run(pool=pool, sql=sql, args=props)
    if result is not None and len(result) == 1:
        logger.debug(
            f"Found existing scope mapping{'' if len(result)==1 else 's'}",
            num=len(result),
            results=result,
        )
    elif result is not None and len(result) > 1:
        logger.debug(
            f"Ambiguous scope mapping.", mapping=scope_mapping, results=list(result)
        )
        raise HTTPException(
            status_code=HTTPStatus.INTERNAL_SERVER_ERROR,
            detail=f"Ambiguous scope mapping for {scope_mapping}.",
        )
    else:
        logger.debug(f"No existing scope mapping.", mapping=scope_mapping)
        return -1

    return int(result[0][0])


async def add_scope_mapping(
    scope_mapping: ScopeMapping,
    pool: Pool,
    overwrite: bool = False,
    token_model: TokenModel = None,
) -> Tuple[int, int]:
    logger.debug(
        "Adding scope mapping",
        scope_mapping=scope_mapping,
    )
    if (
        scope_mapping is None
        or scope_mapping.scope is None
        or scope_mapping.mdid is None
    ):
        raise HTTPException(
            status_code=HTTPStatus.BAD_REQUEST,
            detail=f"Scope mapping {scope_mapping} is invalid",
        )

    return_status_code = HTTPStatus.NO_CONTENT
    mapping_id = await check_scope_mapping_exists(scope_mapping, pool=pool)
    if mapping_id != -1:
        logger.debug(
            "Scope mapping already exists",
            scope_mapping=scope_mapping,
        )
        if overwrite:
            logger.debug(
                "Overwriting scope mapping",
                scope_mapping=scope_mapping,
            )
            await delete_scope_mapping(scope_mapping, pool=pool)
            return_status_code = HTTPStatus.CREATED
        else:
            return mapping_id, HTTPStatus.SEE_OTHER
    else:
        return_status_code = HTTPStatus.CREATED
    logger.debug(
        "Creating scope mapping",
        scope_mapping=scope_mapping,
    )
    mapping_id = await db.insert_data(
        base_model=ScopeMapping, pool=pool, data=[scope_mapping], bulk=False
    )
    logger.debug(
        "Created scope mapping",
        scope_mapping=scope_mapping,
        mapping_id=mapping_id,
    )
    return mapping_id, return_status_code


async def delete_scope_mapping(
    scope_mapping: ScopeMapping,
    pool: Pool,
    token_model: TokenModel = None,
) -> None:
    scope_id = await check_scope_mapping_exists(scope_mapping, pool=pool)
    logger.debug("Deleting existing scope mapping", ids=scope_id)

    sql = f"""
    DELETE FROM `scope_mapping`
    WHERE `id`={scope_id}
    """
    await db.run(pool=pool, sql=sql)
