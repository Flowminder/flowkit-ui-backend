# This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.
import asyncio
from asyncio import sleep

import structlog
import math
import pendulum
import os
from typing import Optional, Dict, AsyncGenerator, AsyncIterable, Tuple, List
from fastapi import HTTPException
from fastapi.responses import StreamingResponse
from aiomysql import Pool, SSDictCursor
from dateutil.relativedelta import relativedelta
from http import HTTPStatus
from dotenv import load_dotenv
from flowkit_ui_backend.models.extra_models import TokenModel
from flowkit_ui_backend.models.query_parameters import QueryParameters
from flowkit_ui_backend.models.spatial_resolution import SpatialResolution
from flowkit_ui_backend.models.spatial_resolutions import SpatialResolutions
from flowkit_ui_backend.models.temporal_resolution import TemporalResolution
from flowkit_ui_backend.models.temporal_resolutions import TemporalResolutions
from flowkit_ui_backend.models.metadata import Metadata
from flowkit_ui_backend.models.time_range import TimeRange
from flowkit_ui_backend.models.category import Category
from flowkit_ui_backend.models.categories import Categories
from flowkit_ui_backend.models.indicator import Indicator
from flowkit_ui_backend.models.indicators import Indicators
from flowkit_ui_backend.models.query_result import QueryResult
from flowkit_ui_backend.impl.util import db, util


load_dotenv()

logger = structlog.get_logger("flowkit_ui_backend.log")

DEFAULT_NUM_BINS = 7
DB_NAME = os.getenv("DB_NAME")
FETCH_CHUNK_SIZE = 150


async def list_categories(pool: Pool, token_model: TokenModel) -> Optional[Categories]:
    logger.warn("TODO: check permissions", token_model=token_model.permissions)
    categories = await db.select_data(base_model=Category, pool=pool, token_model=token_model)
    return Categories(categories=categories)


async def get_category(category_id: str, pool: Pool, token_model: TokenModel) -> Category:
    categories = await db.select_data(
        base_model=Category,
        pool=pool,
        id_key="category_id",
        ids=[category_id],
        token_model=token_model,
    )
    if len(categories) == 0:
        raise HTTPException(status_code=HTTPStatus.NOT_FOUND, detail="Category not found")
    return categories[0]


async def list_indicators(pool: Pool, token_model: TokenModel) -> Optional[Indicators]:
    indicators = await db.select_data(base_model=Indicator, pool=pool, token_model=token_model)
    return Indicators(indicators=indicators)


async def get_indicator(indicator_id: str, pool: Pool, token_model: TokenModel) -> Indicator:
    indicators = await db.select_data(
        base_model=Indicator,
        pool=pool,
        id_key="indicator_id",
        ids=[indicator_id],
        token_model=token_model,
    )
    if len(indicators) == 0:
        raise HTTPException(status_code=HTTPStatus.NOT_FOUND, detail="Indicator not found")
    return indicators[0]


async def get_indicators_for_category(
    category_id: str, pool: Pool, token_model: TokenModel
) -> Optional[Indicators]:
    indicators = await db.select_data(
        base_model=Indicator,
        pool=pool,
        id_key="category_id",
        ids=[category_id],
        token_model=token_model,
    )
    return Indicators(indicators=indicators)


async def list_spatial_resolutions(
    pool: Pool, token_model: TokenModel
) -> Optional[SpatialResolutions]:
    spatial_resolutions = await db.select_data(
        base_model=SpatialResolution,
        pool=pool,
        fields=["srid", "label", "index", "description", "translation"],
        token_model=token_model,
    )
    return SpatialResolutions(spatial_resolutions=spatial_resolutions)


async def get_spatial_resolution(
    srid: int, pool: Pool, token_model: TokenModel
) -> SpatialResolution:
    spatial_resolutions = await db.select_data(
        base_model=SpatialResolution,
        pool=pool,
        id_key="srid",
        ids=[str(srid)],
        token_model=token_model,
    )
    if len(spatial_resolutions) == 0:
        raise HTTPException(status_code=HTTPStatus.NOT_FOUND, detail="Spatial resolution not found")
    return spatial_resolutions[0]


async def get_spatial_resolutions_for_category(
    category_id: str, pool: Pool, token_model: TokenModel
) -> Optional[SpatialResolutions]:
    metadata = await db.select_data(
        base_model=Metadata,
        pool=pool,
        id_key="category_id",
        ids=[category_id],
        token_model=token_model,
    )
    srids = list(set([str(md.srid) for md in metadata]))

    try:
        spatial_resolutions = await db.select_data(
            base_model=SpatialResolution,
            pool=pool,
            id_key="srid",
            fields=["srid", "label", "index", "description", "translation"],
            ids=srids,
        )
    except HTTPException as e:
        if e.status_code != 404:
            raise (e)
        else:
            spatial_resolutions = []

    return SpatialResolutions(spatial_resolutions=spatial_resolutions)


async def list_temporal_resolutions(
    pool: Pool, token_model: TokenModel
) -> Optional[TemporalResolutions]:
    temporal_resolutions = await db.select_data(
        base_model=TemporalResolution, pool=pool, token_model=token_model
    )
    return TemporalResolutions(temporal_resolutions=temporal_resolutions)


async def get_temporal_resolution(
    trid: int, pool: Pool, token_model: TokenModel
) -> TemporalResolution:
    temporal_resolutions = await db.select_data(
        base_model=TemporalResolution,
        pool=pool,
        id_key="trid",
        ids=[str(trid)],
        token_model=token_model,
    )
    if len(temporal_resolutions) == 0:
        raise HTTPException(
            status_code=HTTPStatus.NOT_FOUND, detail="Temporal resolution not found"
        )
    return temporal_resolutions[0]


async def get_temporal_resolutions_for_category(
    category_id: str, pool: Pool, token_model: TokenModel
) -> Optional[TemporalResolutions]:
    metadata = await db.select_data(
        base_model=Metadata,
        pool=pool,
        id_key="category_id",
        ids=[category_id],
        token_model=token_model,
    )
    trids = list(set([str(md.trid) for md in metadata]))
    try:
        temporal_resolutions = await db.select_data(
            base_model=TemporalResolution, pool=pool, id_key="trid", ids=trids
        )
    except HTTPException as e:
        if e.status_code != 404:
            raise (e)
        else:
            temporal_resolutions = []

    return TemporalResolutions(temporal_resolutions=temporal_resolutions)


async def get_time_range(
    category_id: str,
    indicator_id: str,
    srid: int,
    trid: int,
    pool: Pool,
    token_model: TokenModel,
) -> TimeRange:
    # get temporal resolution to know how to format the spatial entities
    temporal_resolutions = await db.select_data(
        base_model=TemporalResolution,
        pool=pool,
        id_key="trid",
        ids=[str(trid)],
        token_model=token_model,
    )

    date_format = temporal_resolutions[0].date_format

    sql = f"""
    SELECT DISTINCT md.`dt`, md.`min_value`, md.`max_value`
    FROM `{DB_NAME}`.`metadata` AS md
    LEFT JOIN `{DB_NAME}`.`scope_mapping` AS sm
    ON sm.`mdid`=md.`mdid`
    WHERE sm.`scope` IN ("{'", "'.join(token_model.permissions)}")
    AND md.`category_id`=%s
    AND md.`indicator_id`=%s
    AND md.`srid`=%s
    AND md.`trid`=%s
    ORDER BY md.`dt` ASC
    """
    args = [category_id, indicator_id, srid, trid]
    (column_names, result) = await db.run(sql, pool=pool, args=args)
    logger.debug(f"Found {len(result)} datasets", result=result)

    logger.debug(f"Formatting dates...", date_format=date_format)
    dates = [row[0].strftime(date_format) for row in result]
    min_value = min([row[1] for row in result]) if len(result) > 0 else None
    max_value = max([row[2] for row in result]) if len(result) > 0 else None

    # fill in missing values
    if len(dates) > 1 and len(temporal_resolutions) > 0:
        tr = temporal_resolutions[0]
        next_date = pendulum.parse(dates[0].replace("w", "-W"))
        end_date = pendulum.parse(dates[-1].replace("w", "-W"))
        all_dates = []
        step = relativedelta()
        setattr(step, tr.relativedelta_unit, tr.relativedelta_num)
        while next_date <= end_date:
            all_dates.append(next_date.strftime(tr.date_format))
            next_date = next_date + step
        dates = all_dates

    time_range = TimeRange()
    if len(dates) > 0:
        time_range = TimeRange(
            start_date=dates[0],
            end_date=dates[-1],
            all_dates=dates,
            min_value=min_value,
            max_value=max_value,
        )

    return time_range


async def get_table_name(
    query_parameters: QueryParameters, token_model: TokenModel, pool: Pool
) -> Tuple[str, str]:
    """
    Gets the base- and specific- table names
    """
    category = await get_category(query_parameters.category_id, token_model=token_model, pool=pool)
    if category.type not in ["single_location", "flow"]:
        raise HTTPException(
            status_code=HTTPStatus.INTERNAL_SERVER_ERROR,
            detail="Could not find category",
        )
    base_table_name = f"{category.type}_data"
    table_name = f"{base_table_name}_{query_parameters.indicator_id}"
    return base_table_name, table_name


def mdid_to_date(mdid: int, metadata: List[Metadata]):
    this_metadata = filter(lambda m: m.mdid == mdid, metadata)
    return next(this_metadata).dt


async def run_query(
    query_parameters: QueryParameters, pool: Pool, token_model: TokenModel
) -> QueryResult:
    # get category to find which data table to use
    base_table_name, table_name = await get_table_name(
        query_parameters, token_model=token_model, pool=pool
    )
    # make sure to amend table name for data tables
    logger.debug(
        "Using indicator-specific data table",
        base_table_name=base_table_name,
        table_name=table_name,
    )
    # get temporal resolution to know how to format the spatial entities
    tr = await get_temporal_resolution(query_parameters.trid, token_model=token_model, pool=pool)

    metadata = await get_metadata(query_parameters, tr, pool, token_model)

    # support getting mdids only
    if query_parameters.mdids_only is True:
        return QueryResult(mdids=[m.mdid for m in metadata])

    logger.debug(f"Found metadata objects, now getting data...", num=len(metadata))

    column_names = await get_column_names(table_name, metadata, pool)

    is_single_value = "spatial_unit_id" in column_names
    is_flow = "origin" in column_names and "destination" in column_names
    data_by_date = {}
    min_value = math.inf
    max_value = -math.inf
    num_rows = 0
    async for chunk in stream_query(base_table_name, metadata, pool, table_name):
        if chunk is None:
            # I don't think I should need to do this?
            break
        for row in chunk:
            num_rows += 1
            # adjust the global min/max if necessary
            min_value = min(row["data"], min_value)
            max_value = max(row["data"], max_value)
            this_date = row["dt"].strftime(tr.date_format)
            data_by_date.setdefault(this_date, {})
            value = util.num(str(row["data"]))
            if is_single_value:
                data_by_date[this_date][row["spatial_unit_id"]] = value
            elif is_flow:
                data_by_date[this_date].setdefault(row["origin"], {})
                if value is not None:
                    data_by_date[this_date][row["origin"]][row["destination"]] = value
            else:
                raise HTTPException(
                    status_code=HTTPStatus.INTERNAL_SERVER_ERROR,
                    detail="Cannot find spatial unit in data",
                )

    logger.debug(
        "Finished running data query",
        num_results=num_rows,
        min_value=min_value,
        max_value=max_value,
    )
    if len(data_by_date.keys()) == 0:
        raise HTTPException(status_code=HTTPStatus.NOT_FOUND, detail="No data found")

    new_result = QueryResult(
        min=min_value if min_value != math.inf else None,
        max=max_value if max_value != -math.inf else None,
        data_by_date=dict(sorted(data_by_date.items())),
    )

    return new_result


async def get_column_names(table_name: str, metadata: List[Metadata], pool: Pool) -> List:
    select_query = (
        f"SELECT * FROM `{os.getenv('DB_NAME')}`.`{table_name}_{metadata[0].mdid}` LIMIT 1;"
    )
    logger.debug("Getting column names", table_name=table_name)
    async with pool.acquire() as conn, conn.cursor() as cursor:
        await cursor.execute(select_query)
        return [i[0] for i in cursor.description]


async def stream_query(
    base_table_name: str, metadata: List[Metadata], pool: Pool, table_name: str
) -> AsyncGenerator[list[dict], None]:
    # table_names is consumed twice, so it needs to be a list
    table_names = [f"`{os.getenv('DB_NAME')}`.`{table_name}_{m.mdid}`" for m in metadata]
    short_names = (table_name.rpartition(".")[2].strip("`") for table_name in table_names)

    partition_queries = (
        f"SELECT `{short_name}`.*, `dt` FROM {table_name} AS `{short_name}` LEFT JOIN metadata USING (mdid)"
        for table_name, short_name in zip(table_names, short_names)
    )
    select_query = " UNION ".join(partition_queries)

    logger.debug(
        "Running data query...",
        base_table_name=base_table_name,
        table_name=f"{table_name}_<mdid>",
    )
    async with pool.acquire() as conn, conn.cursor(SSDictCursor) as cursor:
        await cursor.execute(select_query)

        column_names = [i[0] for i in cursor.description]
        logger.debug("Executed query", column_names=column_names)
        if "data" not in column_names:
            raise HTTPException(
                status_code=HTTPStatus.INTERNAL_SERVER_ERROR,
                detail="Cannot find data for metadata",
            )
        while True:
            chunk = await cursor.fetchmany(FETCH_CHUNK_SIZE)
            if chunk:
                yield chunk
            else:
                break


async def get_metadata(query_parameters, temp_res, pool, token_model) -> List[Metadata]:
    # filter by date
    start_date = pendulum.parse(query_parameters.start_date.replace("w", "-W"))
    step = relativedelta()
    setattr(step, temp_res.relativedelta_unit, temp_res.relativedelta_num)
    # subtracting 1 here because BETWEEN in the SQL includes the end date
    end_date = start_date + step * (query_parameters.duration - 1)
    sql = f"""
    SELECT * FROM `{DB_NAME}`.`metadata` AS md
    LEFT JOIN `{DB_NAME}`.`scope_mapping` AS sm
    ON sm.mdid=md.mdid
    WHERE sm.scope IN ("{'", "'.join(token_model.permissions)}")
    AND md.`category_id`=%s
    AND md.`indicator_id`=%s
    AND md.`srid`=%s
    AND md.`trid`=%s
    AND md.`dt` BETWEEN %s AND %s
    ORDER BY md.`dt` ASC
    """
    args = [
        query_parameters.category_id,
        query_parameters.indicator_id,
        query_parameters.srid,
        query_parameters.trid,
        # aiomysql apparently doesn't pass in dates like mysql-connector-python does hence the need to format here
        start_date.format("YYYY-MM-DD HH:mm:ss"),
        end_date.format("YYYY-MM-DD HH:mm:ss"),
    ]
    logger.debug("Running metadata query", sql=sql, args=args)
    (column_names, result) = await db.run(sql, pool=pool, args=args)
    logger.debug("Finished running metadata query")
    if not result:
        raise HTTPException(status_code=HTTPStatus.NOT_FOUND, detail="No metadata found")
    metadata_args = [
        {col_name: value for col_name, value in zip(column_names, row)} for row in result
    ]
    return [Metadata(**metadata_item) for metadata_item in metadata_args]


async def run_csv_query(
    query_parameters: QueryParameters, pool: Pool, token_model: TokenModel
) -> StreamingResponse:
    return StreamingResponse(stream_csv(query_parameters, pool, token_model))


async def stream_csv(
    query_parameters: QueryParameters, pool: Pool, token_model: TokenModel
) -> AsyncGenerator[str, None]:
    base_table_name, table_name = await get_table_name(
        query_parameters, pool=pool, token_model=token_model
    )
    tr = await get_temporal_resolution(query_parameters.trid, token_model=token_model, pool=pool)
    metadata = await get_metadata(query_parameters, tr, pool, token_model)
    query_stream_generator = stream_query(base_table_name, metadata, pool, table_name)
    if query_parameters.category_id.lower() in ["residents", "presence"]:
        async for csv_chunk in stream_region_to_csv(query_stream_generator):
            yield csv_chunk
    elif query_parameters.category_id.lower() in ["relocations", "movements"]:
        async for csv_chunk in stream_flows_to_csv(query_stream_generator):
            yield csv_chunk
    else:
        raise HTTPException(
            status_code=HTTPStatus.NOT_IMPLEMENTED,
            detail=f"CSV not yet implemented for {query_parameters.category_id.lower()}",
        )


async def stream_region_to_csv(
    region_stream: AsyncGenerator,
) -> AsyncGenerator[str, None]:
    yield "date,area_code,value\r\n"
    async for chunk in region_stream:
        if chunk:
            yield "\r\n".join(
                f"{row['dt'].strftime('%Y-%m-%d')},{row['spatial_unit_id']},{row['data']}"
                for row in chunk
            ) + "\r\n"
    yield "\r\n"


async def stream_flows_to_csv(flow_stream: AsyncGenerator) -> AsyncGenerator[str, None]:
    yield "date,origin_code,destination_code,value\r\n"
    async for chunk in flow_stream:
        if chunk:
            yield "\r\n".join(
                f"{row['dt'].strftime('%Y-%m-%d')},{row['origin']},{row['destination']},{row['data']}"
                for row in chunk
            ) + "\r\n"
    yield "\r\n"
