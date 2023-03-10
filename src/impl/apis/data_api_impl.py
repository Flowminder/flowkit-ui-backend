# This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

import structlog
import math
import pendulum
import os
import cProfile
import pstats
from typing import Optional
from fastapi import HTTPException
from aiomysql import Pool
from dateutil.relativedelta import relativedelta
from http import HTTPStatus
from dotenv import load_dotenv
from flowkit_ui_backend.models.query_parameters import QueryParameters
from flowkit_ui_backend.models.spatial_resolution import SpatialResolution
from flowkit_ui_backend.models.spatial_resolutions import SpatialResolutions
from flowkit_ui_backend.models.temporal_resolution import TemporalResolution
from flowkit_ui_backend.models.temporal_resolutions import TemporalResolutions
from flowkit_ui_backend.models.metadata import Metadata
from flowkit_ui_backend.models.single_location_data import SingleLocationData
from flowkit_ui_backend.models.flow_data import FlowData
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


async def list_categories(pool: Pool = None) -> Optional[Categories]:
    categories = await db.select_data(base_model=Category, pool=pool)
    return Categories(categories=categories)


async def get_category(category_id: str, pool: Pool = None) -> Category:
    categories = await db.select_data(
        base_model=Category, id_key="category_id", ids=[category_id], pool=pool
    )
    if len(categories) == 0:
        raise HTTPException(status_code=HTTPStatus.NOT_FOUND, detail="Category not found")
    return categories[0]


async def list_indicators(pool: Pool = None) -> Optional[Indicators]:
    indicators = await db.select_data(base_model=Indicator, pool=pool)
    return Indicators(indicators=indicators)


async def get_indicator(indicator_id: str, pool: Pool = None) -> Indicator:
    indicators = await db.select_data(
        base_model=Indicator, id_key="indicator_id", ids=[indicator_id], pool=pool
    )
    if len(indicators) == 0:
        raise HTTPException(status_code=HTTPStatus.NOT_FOUND, detail="Indicator not found")
    return indicators[0]


async def get_indicators_for_category(category_id: str, pool: Pool = None) -> Optional[Indicators]:
    indicators = await db.select_data(
        base_model=Indicator, id_key="category_id", ids=[category_id], pool=pool
    )
    return Indicators(indicators=indicators)


async def list_spatial_resolutions(pool: Pool = None) -> Optional[SpatialResolutions]:
    spatial_resolutions = await db.select_data(
        base_model=SpatialResolution,
        # leave out the actual boundary - that will be retrieved individually
        fields=["srid", "label", "index", "description", "translation"],
        pool=pool,
    )
    return SpatialResolutions(spatial_resolutions=spatial_resolutions)


async def get_spatial_resolution(srid: int, pool: Pool = None) -> SpatialResolution:
    spatial_resolutions = await db.select_data(
        base_model=SpatialResolution, id_key="srid", ids=[str(srid)], pool=pool
    )
    if len(spatial_resolutions) == 0:
        raise HTTPException(status_code=HTTPStatus.NOT_FOUND, detail="Spatial resolution not found")
    return spatial_resolutions[0]


async def get_spatial_resolutions_for_category(
    category_id: str, pool: Pool = None
) -> Optional[SpatialResolutions]:
    metadata = await db.select_data(
        base_model=Metadata, id_key="category_id", ids=[category_id], pool=pool
    )
    srids = list(set([str(md.srid) for md in metadata]))

    try:
        spatial_resolutions = await db.select_data(
            base_model=SpatialResolution,
            id_key="srid",
            ids=srids,
            fields=["srid", "label", "index", "description", "translation"],
            pool=pool,
        )
    except HTTPException as e:
        if e.status_code != 404:
            raise (e)
        else:
            spatial_resolutions = []

    return SpatialResolutions(spatial_resolutions=spatial_resolutions)


async def list_temporal_resolutions(pool: Pool = None) -> Optional[TemporalResolutions]:
    temporal_resolutions = await db.select_data(base_model=TemporalResolution, pool=pool)
    return TemporalResolutions(temporal_resolutions=temporal_resolutions)


async def get_temporal_resolution(trid: int, pool: Pool = None) -> TemporalResolution:
    temporal_resolutions = await db.select_data(
        base_model=TemporalResolution, id_key="trid", ids=[str(trid)], pool=pool
    )
    if len(temporal_resolutions) == 0:
        raise HTTPException(
            status_code=HTTPStatus.NOT_FOUND, detail="Temporal resolution not found"
        )
    return temporal_resolutions[0]


async def get_temporal_resolutions_for_category(
    category_id: str, pool: Pool = None
) -> Optional[TemporalResolutions]:
    metadata = await db.select_data(
        base_model=Metadata, id_key="category_id", ids=[category_id], pool=pool
    )
    trids = list(set([str(md.trid) for md in metadata]))
    try:
        temporal_resolutions = await db.select_data(
            base_model=TemporalResolution, id_key="trid", ids=trids, pool=pool
        )
    except HTTPException as e:
        if e.status_code != 404:
            raise (e)
        else:
            temporal_resolutions = []

    return TemporalResolutions(temporal_resolutions=temporal_resolutions)


async def get_time_range(
    category_id: str, indicator_id: str, srid: int, trid: int, pool: Pool = None
) -> TimeRange:
    # get temporal resolution to know how to format the spatial entities
    temporal_resolutions = await db.select_data(
        base_model=TemporalResolution, id_key="trid", ids=[str(trid)], pool=pool
    )

    date_format = temporal_resolutions[0].date_format

    sql = f"""
    SELECT DISTINCT `dt`, `min_value`, `max_value`
    FROM `{os.getenv('DB_NAME')}`.`metadata`
    WHERE `category_id`=%s
    AND `indicator_id`=%s
    AND srid=%s
    AND trid=%s
    ORDER BY dt ASC
    """
    args = [category_id, indicator_id, srid, trid]
    (column_names, result) = await db.run(sql, args, pool=pool)
    logger.debug(f"Found {len(result)} datasets")

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


async def run_query(query_parameters: QueryParameters, pool: Pool = None) -> QueryResult:
    # get category to find which data table to use
    logger.debug("Get category object")
    categories = await db.select_data(
        base_model=Category, id_key="category_id", ids=[query_parameters.category_id], pool=pool
    )
    category = categories[0]
    # make sure to amend table name for data tables
    base_table_name = f"{category.type}_data"
    table_name = f"{base_table_name}_{query_parameters.indicator_id}"
    logger.debug(
        "Using indicator-specific data table",
        base_table_name=base_table_name,
        table_name=table_name,
    )

    # get temporal resolution to know how to format the spatial entities
    logger.debug("Get temporal resolution object")
    temporal_resolutions = await db.select_data(
        base_model=TemporalResolution, id_key="trid", ids=[str(query_parameters.trid)], pool=pool
    )
    tr = temporal_resolutions[0]

    if (
        len(categories) == 0
        or len(temporal_resolutions) == 0
        or categories[0].type not in ["single_location", "flow"]
    ):
        raise HTTPException(
            status_code=HTTPStatus.NOT_FOUND,
            detail="Could not find category or temporal resolution",
        )

    # filter by date
    start_date = pendulum.parse(query_parameters.start_date.replace("w", "-W"))
    step = relativedelta()
    setattr(step, tr.relativedelta_unit, tr.relativedelta_num)
    # subtracting 1 here because BETWEEN in the SQL includes the end date
    end_date = start_date + step * (query_parameters.duration - 1)

    sql = f"""
    SELECT * FROM `{DB_NAME}`.`metadata` AS md
    WHERE md.`category_id`=%s
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
    (column_names, result) = await db.run(sql, args, pool=pool)
    logger.debug("Finished running metadata query")
    if not result:
        raise HTTPException(status_code=HTTPStatus.NOT_FOUND, detail="No metadata found")

    mdids = [str(md[1]) for md in result]
    mdid_to_date = {str(md[1]): md[8] for md in result}
    logger.debug(f"Found metadata objects, now getting data...", num=len(mdids))

    # make sure to amend table name for data tables
    base_table_name = f"{category.type}_data"
    table_name = f"{base_table_name}_{query_parameters.indicator_id}"

    # manually querying to make use of partitions
    table_names = [f"`{os.getenv('DB_NAME')}`.`{table_name}_{mdid}`" for mdid in mdids]
    union_string = f" UNION SELECT * FROM ".join(table_names)
    select_query = f"SELECT * FROM {union_string};"
    logger.debug(
        "Running data query...",
        base_table_name=base_table_name,
        table_name=f"{table_name}_<mdid>",
    )
    data_by_date = {}
    min_value = math.inf
    max_value = -math.inf
    async with pool.acquire() as conn, conn.cursor() as cursor:
        with cProfile.Profile() as pr:
            await cursor.execute(select_query)
        stats = pstats.Stats(pr)
        stats.sort_stats(pstats.SortKey.TIME)
        stats.print_stats(10)
        # await cursor.execute(select_query)
        column_names = [i[0] for i in cursor.description]
        logger.debug("Executed query", column_names=column_names)
        if "data" not in column_names:
            raise HTTPException(
                status_code=HTTPStatus.INTERNAL_SERVER_ERROR,
                detail="Cannot find data for metadata",
            )
        data_index = column_names.index("data")
        mdid_index = column_names.index("mdid")
        is_single_value = "spatial_unit_id" in column_names
        if is_single_value:
            spatial_unit_id_index = column_names.index("spatial_unit_id")
        is_flow = "origin" in column_names and "destination" in column_names
        if is_flow:
            origin_index = column_names.index("origin")
            destination_index = column_names.index("destination")
        done = False
        num_rows = 0
        with cProfile.Profile() as pr:
            while not done:
                row = await cursor.fetchone()
                if row is not None:
                    num_rows += 1
                    # adjust the global min/max if necessary
                    min_value = min([row[data_index], min_value])
                    max_value = max([row[data_index], max_value])

                    this_date = mdid_to_date[str(row[mdid_index])].strftime(tr.date_format)
                    data_by_date.setdefault(this_date, {})
                    value = util.num(str(row[data_index]))

                    if is_single_value:
                        data_by_date[this_date][row[spatial_unit_id_index]] = value
                    elif is_flow:
                        data_by_date[this_date].setdefault(row[origin_index], {})
                        if value is not None:
                            data_by_date[this_date][row[origin_index]][
                                row[destination_index]
                            ] = value
                    else:
                        raise HTTPException(
                            status_code=HTTPStatus.INTERNAL_SERVER_ERROR,
                            detail="Cannot find spatial unit in data",
                        )
                else:
                    done = True
        stats = pstats.Stats(pr)
        stats.sort_stats(pstats.SortKey.TIME)
        stats.print_stats(10)
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
