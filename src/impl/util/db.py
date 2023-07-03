# This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

import structlog
import os
import re
import json
import os
import traceback
import typing
import aiofiles
from fastapi import HTTPException
from typing import List, Tuple, Optional
from asyncio import sleep
from pathlib import Path
from xmlrpc.client import boolean
from http import HTTPStatus
from aiomysql import Pool
from pydantic import BaseModel
from flowkit_ui_backend.models.extra_models import TokenModel
from flowkit_ui_backend.impl.util import util


logger = structlog.get_logger("flowkit_ui_backend.log")


SCHEMA_PATH = f"/home/{os.getenv('APP_DIR')}/src-generated/schema"
PERSISTENT_FIRST_RUN = f"/home/{os.getenv('APP_DIR')}/FIRST_RUN"
INDICES = {
    "metadata": ["dt", "mdid", "trid", "srid", "category_id", "indicator_id"],
    "scope_mapping": ["mdid", "scope"],
    "single_location_data": ["mdid"],
    "flow_data": ["mdid"],
}


async def provision_db(pool: Pool) -> boolean:
    # can't use env vars as they are reset whenever the dev server reloads
    if os.path.isfile(PERSISTENT_FIRST_RUN):
        logger.debug("This is a subsequent run. Skipping provisioning... ")
        return False
    try:
        # Force delete existing tables
        logger.debug(f"Force DB setup? {os.getenv('FORCE_DB_SETUP')}")
        if os.getenv("FORCE_DB_SETUP") == "1":
            (column_names, result) = await run(
                f"SHOW TABLES FROM {os.getenv('DB_NAME')};", pool=pool
            )
            if len(result) > 0:
                logger.debug(f"Deleting {len(result)} existing tables")
                # delete existing tables
                await run(
                    f"DROP TABLE IF EXISTS `{'`, `'.join([os.getenv('DB_NAME') + '`.`' + i[0] for i in result])}`",
                    pool=pool,
                )
                logger.debug("Done.")
            else:
                logger.debug(f"No existing tables found")

        # recreate tables from schema
        logger.debug("Creating db schema")
        success = await run_script(f"{SCHEMA_PATH}/mysql_schema.sql", pool=pool)
        if not success:
            logger.error("Could not set up database.")
            return False
        logger.debug("Done.")

        # waiting so the db has time to commit the schema
        sleep(0.5)

        # add index to speed up queries
        await add_indices(pool=pool)

        # make sure this won't run again but only here where it was successful
        Path(PERSISTENT_FIRST_RUN).touch()
        return success
    except Exception as e:
        logger.error(e)
        logger.error(traceback.format_exc())
    return False


async def get_index(table: str, column: str, pool: Pool) -> str:
    (columns_names, result) = await run(
        f"SHOW INDEXES FROM `{os.getenv('DB_NAME')}`.`{table}` WHERE `Column_name`='{column}'",
        pool=pool,
    )
    if result is None or len(result) == 0:
        logger.debug(f"No index found on table `{table}` for column `{column}`")
        return None
    index_name = result[0][2]
    logger.debug(f"Found index `{index_name}` for table `{table}` on column {column}")
    return index_name


async def add_index(table: str, column: str, pool: Pool) -> str:
    index_name = f"index_{table}_{column}"
    logger.debug(f"Adding index `{index_name}` to table `{table}`, column {column}...")
    await run(
        f"ALTER TABLE `{os.getenv('DB_NAME')}`.`{table}` ADD INDEX `{index_name}` (`{column}`)",
        pool=pool,
    )
    logger.debug("Done.")
    return index_name


async def drop_index(table: str, column: str, pool: Pool):
    index_name = f"index_{table}_{column}"
    logger.debug(f"Dropping index `{index_name}`...")
    await run(
        f"DROP INDEX `{index_name}` ON `{os.getenv('DB_NAME')}`.`{table}`", pool=pool
    )
    logger.debug("Done.")


async def add_indices(pool: Pool):
    for table, index_list in INDICES.items():
        for index in index_list:
            index_name = await get_index(table=table, column=index, pool=pool)
            if index_name is None:
                await add_index(table=table, column=index, pool=pool)


async def drop_indices(pool: Pool):
    for table, index_list in INDICES.items():
        for index in index_list:
            index_name = await get_index(table=table, column=index, pool=pool)
            if index_name is not None:
                await drop_index(table=table, column=index, pool=pool)


async def load_prepared_sql(base_model: BaseModel, query_type: str) -> str:
    queries_dir = f"{SCHEMA_PATH}/Model"
    async with aiofiles.open(f"{queries_dir}/{base_model.__name__}.sql") as f:
        contents = await f.read()
        return re.compile(r"^" + re.escape(query_type) + r".*", re.MULTILINE).findall(
            contents
        )[0]


async def run(
    sql: str, pool: Pool, args: Optional[list] = None
) -> Tuple[List[str], List[tuple]]:
    async with pool.acquire() as conn, conn.cursor() as cursor:
        if args is not None:
            await cursor.execute(sql, args=args)
        else:
            await cursor.execute(sql)

        result = await cursor.fetchall()
        column_names = []
        if cursor.description is not None and len(cursor.description) > 0:
            column_names = [str(i[0]) for i in cursor.description]

    return (column_names, result)


async def run_script(script_path: str, pool: Pool) -> boolean:
    success = False
    try:
        async with aiofiles.open(script_path) as script:
            async with pool.acquire() as conn, conn.cursor() as cursor:
                await cursor.execute(await script.read())
                success = True
    except Exception as e:
        logger.error(f"Could not run script {script_path}")
        print(e)

    return success


async def select_data(
    base_model: BaseModel,
    pool: Pool,
    id_key: Optional[str] = None,
    fields: Optional[List[str]] = None,
    table_name_override: str = None,
    ids: Optional[List[str]] = None,
    token_model: TokenModel = None,
) -> List[BaseModel]:
    if id_key is not None and (ids is None or len(ids) == 0):
        raise HTTPException(
            status_code=HTTPStatus.NOT_FOUND,
            detail=f"No data found for {base_model.__name__} with {id_key} {ids}",
        )

    # determine table name - conveniently it's the same as the python module name for the data type
    table_name = (
        table_name_override
        if table_name_override is not None
        else base_model.__module__.split(".")[-1]
    )
    fields_string = (
        ", ".join(f"`{field}`" for field in fields) if fields is not None else "*"
    )
    select_query = (
        f"SELECT {fields_string} FROM `{os.getenv('DB_NAME')}`.`{table_name}`"
    )

    # permissions apply to these objects
    object_mapping_ids = {
        "metadata": "mdid",
        "category": "category_id",
        "indicator": "indicator_id",
        "spatial_resolution": "srid",
        "temporal_resolution": "trid",
    }
    actual_ids = ids
    if token_model is not None and table_name in object_mapping_ids.keys():
        id_key = object_mapping_ids[table_name] if id_key is None else id_key
        # get all IDs for objects of this type that are permissible for the token
        permissible_ids_query = f"""
        SELECT md.`{id_key}` FROM `{os.getenv("DB_NAME")}`.`metadata` AS md
        LEFT JOIN `{os.getenv("DB_NAME")}`.`scope_mapping` AS sm
        ON sm.mdid=md.mdid
        WHERE sm.scope IN ("{'", "'.join(token_model.permissions)}")
        GROUP BY md.`{id_key}`"""
        logger.debug(
            "Querying for allowable ids",
            query=permissible_ids_query,
        )
        async with pool.acquire() as conn, conn.cursor() as cursor:
            await cursor.execute(permissible_ids_query)
            permissible_ids = [str(i[0]) for i in await cursor.fetchall()]
        logger.debug(
            "Filtering IDs based on permissions...",
            id_key=id_key,
            ids=ids,
            permissible_ids=permissible_ids,
        )
        actual_ids = (
            permissible_ids if ids is None else list(set(ids) & set(permissible_ids))
        )

    if id_key is not None and actual_ids is not None:
        ids_string = "', '".join([str(the_id) for the_id in actual_ids])
        # yes, this is not 100% safe but apparently you cannot parametrise column names :(
        # TODO: maybe switch to another library that *does* support it?
        select_query = f"{select_query} WHERE `{id_key}` IN ('{ids_string}')"

    logger.debug("Before query", select_query=select_query)

    async with pool.acquire() as conn, conn.cursor() as cursor:
        await cursor.execute(select_query)
        column_names = [i[0] for i in cursor.description]

        done = False
        result = []
        while not done:
            row = await cursor.fetchone()
            if row is not None:
                result.append(row)
            else:
                done = True

    logger.debug("After query", num_results=len(result))

    # restore the objects
    objects = []
    fields = base_model.__fields__
    # get data types. we need this to check if there are any collection types in the data - they need special treatment
    types = typing.get_type_hints(base_model)
    actual_types = dict(
        (
            t,
            typing.get_args(types[t])[0]
            if typing.get_origin(types[t]) == typing.Union
            else types[t],
        )
        for t in types
    )

    logger.debug("Restoring objects")
    for row in result:
        # first get all fields from the base model,
        # then their position in the sql result and finally
        # the value from the result set at that position
        obj_init_dict = dict(
            (f, row[column_names.index(f)]) for f in fields if f in column_names
        )
        # special treatment for lists/dicts: deserialise str to JSON
        for k in obj_init_dict:
            if (
                typing.get_origin(actual_types[k]) in [list, dict]
                and obj_init_dict[k] is not None
            ):
                obj_init_dict[k] = json.loads(obj_init_dict[k])
        obj = base_model(**obj_init_dict)
        restored_obj = util.restore_translation(obj)
        if restored_obj is not None:
            objects.append(restored_obj)
    logger.debug("Done restoring objects")

    return objects


async def insert_data(
    base_model: BaseModel,
    pool: Pool,
    id_key: Optional[str] = None,
    data: List[object] = [],
    bulk: boolean = False,
    table_name_override: Optional[str] = None,
) -> Optional[int]:
    insert_query = await load_prepared_sql(base_model, "INSERT")

    # determine table name - conveniently it's the same as the python module name for the data type
    table_name = base_model.__module__.split(".")[-1]

    if table_name_override is not None:
        logger.debug(
            "Replacing table for insert query",
            table_name=table_name,
            table_name_override=table_name_override,
        )
        insert_query = insert_query.replace(table_name, table_name_override)
        table_name = table_name_override
    logger.debug("Starting insert", target=table_name)
    # get all properties in the same order they're in the insert SQL
    props = (
        re.compile(r"\(`.*`\)")
        .findall(insert_query)[0]
        .replace("(", "")
        .replace(")", "")
        .replace("`", "")
        .replace(" ", "")
        .split(",")
    )

    field_sep = ","
    line_sep = "\n"
    all_values = []
    for d in data:
        d = await util.add_translation(d, pool=pool, props=props)
        d = util.serialise_props(d, props)

        # get property values in the correct order
        if bulk:
            all_values.append(
                field_sep.join(
                    [
                        str(getattr(d, prop)) if getattr(d, prop) is not None else "\\N"
                        for prop in props
                    ]
                )
            )
        else:
            all_values.append([getattr(d, prop) for prop in props])

    async with pool.acquire() as conn, conn.cursor() as cursor:
        if bulk:
            async with aiofiles.tempfile.NamedTemporaryFile("wb") as tmpfile:
                logger.debug("Writing data to tmp file", file_name=tmpfile.name)
                await tmpfile.write(line_sep.join(all_values).encode("utf-8"))
                # need to set file pointer back to beginning before we can read in the next step
                await tmpfile.seek(0)
                logger.debug("Done writing data to tmp file", file_name=tmpfile.name)
                sql = f"""
                LOAD DATA LOCAL
                INFILE '{tmpfile.name}'
                INTO TABLE `{os.getenv('DB_NAME')}`.`{table_name}`
                FIELDS TERMINATED BY '{field_sep}'
                LINES TERMINATED BY '{line_sep}'
                (`{'`,`'.join(props)}`)
                """
                logger.debug(
                    "Executing LOAD DATA", source=tmpfile.name, target=table_name
                )
                await cursor.execute(sql)
                logger.debug(
                    "Executed LOAD DATA", source=tmpfile.name, target=table_name
                )

        elif len(all_values) == 1:
            await cursor.execute(insert_query, all_values[0])
        else:
            # logger.debug("Execute INSERT")
            await cursor.executemany(insert_query, all_values)

        last_id = cursor.lastrowid
        logger.debug(
            f"Inserted data",
            table=table_name,
            num_rows=cursor.rowcount,
            bulk=bulk,
            last_id=last_id,
        )

        # now make sure to update the id key (which is a separate field from the primary key)
        if id_key is not None:
            # logger.debug("Update ID key")
            update_query = await load_prepared_sql(base_model, "UPDATE")
            update_query = update_query.split(" SET", 1)[0]
            # should trigger an error if replaced
            escaped_id_key = id_key if id_key.isidentifier() else None
            update_query = f"{update_query} SET `{escaped_id_key}`=`id` WHERE `{escaped_id_key}` IS NULL"
            await cursor.execute(update_query)
            # logger.debug("Done")
            logger.debug(
                f"Updated id key",
                table=table_name,
                num_rows=cursor.rowcount,
                escaped_id_key=escaped_id_key,
                id_key=id_key,
                update_query=update_query,
            )

    return last_id


async def update_data(
    base_model: BaseModel,
    pool: Pool,
    id_value: object = None,
    resource: BaseModel = None,
    id_key: str = None,
):
    if id_key is None:
        raise Exception("ID key not given, can't update without it.")
    id_value = id_value if id_value is not None else getattr(resource, id_key)

    update_query = await load_prepared_sql(base_model, "UPDATE")

    # get all properties in the same order they're in the update SQL
    matches = re.compile(r"`[a-zA-Z_]+` = %s").findall(update_query)
    props = [prop.replace("`", "").replace(" = %s", "") for prop in matches]

    resource = await util.add_translation(resource, pool=pool, props=props)
    resource = util.serialise_props(resource, props)

    # get property values in the correct order
    all_values = [getattr(resource, prop) for prop in props]

    async with pool.acquire() as conn, conn.cursor() as cursor:
        logger.debug("Execute UPDATE")
        # use ID to filter
        all_values.append(id_value)
        update_query = update_query.replace("WHERE 1", f"WHERE `{id_key}`=%s")
        await cursor.execute(update_query, all_values)
        logger.debug(
            f"Updated {cursor.rowcount} row(s) in the {base_model.__name__} table"
        )


async def delete_data(
    base_model: BaseModel,
    pool: Pool,
    ids: Optional[List[str]] = None,
    id_key: Optional[str] = None,
):
    # Clear db
    delete_query = await load_prepared_sql(base_model, "DELETE")

    async with pool.acquire() as conn, conn.cursor() as cursor:
        if id_key is not None and ids is not None and len(ids) > 0:
            logger.debug(f"Deleting selected data...", table=base_model.__name__)
            ids_string = "', '".join([str(the_id) for the_id in ids])
            # yes, this is not 100% safe but apparently you cannot parametrise column names :(
            # TODO: maybe switch to another library that *does* support it?
            delete_query = delete_query.replace(
                "WHERE 1", f"WHERE `{id_key}` IN (%(ids_string)s)"
            )
            await cursor.execute(delete_query, {"ids_string": ids_string})
        else:
            logger.debug(f"Deleting all data...", table=base_model.__name__)
            await cursor.execute(delete_query)

        logger.debug(
            f"Finished deleting.", table=base_model.__name__, num_rows=cursor.rowcount
        )


# insert a new object into the db or return an existing one
async def add_resource_with_unique_id(
    resource: BaseModel, base_model: BaseModel, id_key: str, pool: Pool
) -> Tuple[BaseModel, int]:
    ids = (
        [getattr(resource, id_key)]
        if hasattr(resource, id_key) and getattr(resource, id_key) is not None
        else None
    )
    try:
        existing_resource = await select_data(
            base_model=base_model,
            pool=pool,
            id_key=id_key if ids is not None else None,
            ids=ids,
        )
        if existing_resource not in [None, []]:
            return existing_resource[0], HTTPStatus.SEE_OTHER
    except HTTPException as e:
        if e.status_code != HTTPStatus.NOT_FOUND:
            raise (e)

    await insert_data(base_model=base_model, pool=pool, id_key=id_key, data=[resource])
    new_resource = await select_data(
        base_model=base_model,
        pool=pool,
        id_key=id_key if ids is not None else None,
        ids=ids,
    )
    return new_resource[0], HTTPStatus.CREATED


# update an existing resource or throw an error
async def update_resource_with_unique_id(
    resource: BaseModel,
    base_model: BaseModel,
    id_key: str,
    id_value: object,
    pool: Pool,
):
    # cannot change ID!
    if getattr(resource, id_key) != id_value:
        raise HTTPException(
            status_code=HTTPStatus.BAD_REQUEST,
            detail=f"Resource's `{id_key}` '{getattr(resource, id_key)}' doesn't match value {id_value}",
        )

    existing_resource = await select_data(
        base_model=base_model, pool=pool, id_key=id_key, ids=[getattr(resource, id_key)]
    )
    if len(existing_resource) == 0:
        raise HTTPException(
            status_code=HTTPStatus.NOT_FOUND,
            detail="Could not update resource - not found",
        )

    try:
        await update_data(
            base_model=base_model,
            pool=pool,
            id_value=id_value,
            resource=resource,
            id_key=id_key,
        )
    except Exception as e:
        raise HTTPException(
            status_code=HTTPStatus.BAD_REQUEST,
            detail="Could not update resource. Please check it is valid: {e}",
        )

    return None
