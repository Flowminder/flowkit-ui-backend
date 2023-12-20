# This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

from __future__ import annotations
import os
import glob
import json
import structlog
import aiofiles
from aiocsv import AsyncReader
from typing import Union
from pydantic import BaseModel
from aiomysql import Pool
from flowkit_ui_backend.db import db
from flowkit_ui_backend.models.config import Config
from flowkit_ui_backend.models.language import Language


logger = structlog.get_logger("flowkit_ui_backend.log")


def num(s: str) -> Union[int, float]:
    try:
        try:
            return int(s)
        except ValueError:
            return float(s)
    except:
        pass
    return None


def load_config_from_json(json_path: str) -> Config:
    with open(json_path) as f:
        try:
            cfg = json.load(f)
            return Config(**cfg)
        except Exception as e:
            logger.error(e)


async def load_data_from_csv(csv_path: str) -> dict:
    data = dict()
    for file_name in glob.glob(csv_path):
        data_file = os.path.basename(file_name).replace(".csv", "")
        if not data_file in data:
            data[data_file] = []
        try:
            async with aiofiles.open(file_name) as csvDataFile:
                async for row in AsyncReader(csvDataFile):
                    data[data_file].append(row)
            # keep header row - use for identifying indicators later
            # data[data_file].pop(0)
        except Exception as e:
            logger.debug(e)
    return data


# take individual properties and turn them into a serialised "translation" field
async def add_translation(
    resource: BaseModel, pool: Pool, props: list[str] = []
) -> BaseModel:
    # if this data type supports i18n we'll add the possible extra fields
    if hasattr(resource, "translation"):
        languages = [
            l.code
            for l in await db.select_data(base_model=Language, pool=pool)
            if l.default == False
        ]
        # compute all possible property names depending on the ingested languages
        extra_props = [f"{p}_{l.lower()}" for l in languages for p in props]

        translation = {}
        # check if any of the possible translations were passed in as extra properties
        for ep in extra_props:
            if ep in dir(resource):
                original_label, lang = ep.split("_")
                # if they exist we'll add them to the translation JSON
                translation.setdefault(lang, {})
                value = getattr(resource, ep)
                if value is not None:
                    translation[lang][original_label] = value
        # remove empty languages
        to_delete = []
        for lang in translation:
            if translation[lang] == {}:
                to_delete.append(lang)
        for lang in to_delete:
            translation.pop(lang, None)
        # serialise JSON as it will go into a single field in the db
        setattr(
            resource,
            "translation",
            None if translation == {} else json.dumps(translation),
        )
    return resource


# take a serialised "translation" field and turn it into extra properties on the object
def restore_translation(obj: BaseModel) -> BaseModel:
    if (
        hasattr(obj, "translation")
        and obj.translation is not None
        and getattr(obj, "translation") not in [None, "", "{}"]
    ):
        translation = json.loads(obj.translation)
        if translation is not None and translation != {}:
            for lang in translation.keys():
                for original_label in translation[lang]:
                    extra_label = f"{original_label}_{lang}"
                    setattr(obj, extra_label, translation[lang][original_label])
        del obj.translation

    return obj


def serialise_props(resource: BaseModel, props: list[str] = []) -> BaseModel:
    # check if any of the props are really JSON
    for prop in props:
        if type(getattr(resource, prop)) == list:
            # serialise a list of objects
            setattr(
                resource,
                prop,
                json.dumps(getattr(resource, prop), default=lambda obj: obj.__dict__),
            )
        elif type(getattr(resource, prop)) == dict:
            # serialise a single object
            setattr(
                resource,
                prop,
                json.dumps(getattr(resource, prop), default=lambda obj: obj.__dict__),
            )
    return resource
