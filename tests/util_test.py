# This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

import os
from pathlib import Path

import pytest
import flowkit_ui_backend.util.util as util
from flowkit_ui_backend.models.config import Config
from flowkit_ui_backend.models.category import Category
from flowkit_ui_backend.models.indicator import Indicator
from flowkit_ui_backend.models.language import Language


def test_num():
    assert isinstance(util.num("5.0"), float)
    assert isinstance(util.num("5"), int)
    assert util.num("bob") is None


def test_load_config_from_json():
    # inexistent file
    with pytest.raises(Exception) as e:
        util.load_config_from_json("")

    # invalid file
    config = util.load_config_from_json(f"{os.getenv('PWD')}/../resources/test.csv")
    assert config is None

    config = util.load_config_from_json(f"{os.getenv('PWD')}/../resources/config.json")
    print(config)
    assert type(config) == Config


@pytest.mark.asyncio
async def test_load_data_from_csv():
    # inexistent file
    result = await util.load_data_from_csv("")
    assert result == {}
    data_path = Path(__file__).parent.parent / "resources"
    # invalid file
    filename = data_path / "invalid.csv"
    os.chmod(filename, 0o220)
    result = await util.load_data_from_csv(str(filename))
    assert result == {"invalid": []}
    os.chmod(filename, 0o660)

    result = await util.load_data_from_csv(str(data_path / "*.csv"))
    keys = list(result.keys())
    assert "test" in keys
    assert "test2" in keys
    assert "residents_indicators_people" in keys
    assert len(list(result.items())) == 4


@pytest.mark.asyncio
async def test_add_translation(mocker):
    languages = [
        Language(lid=1, code="fo", name="Foo", flag="foo.svg", default=True),
        Language(lid=2, code="ba", name="Bar", flag="bar.svg", default=False),
        Language(lid=2, code="bz", name="Baz", flag="baz.svg", default=False),
    ]
    mocker.patch(
        "flowkit_ui_backend.impl.general_api_impl.db.select_data",
        side_effect=[languages, languages, languages],
    )

    # no translation
    cat = Category(category_id="foo", type="single_location", label="foo")
    result = await util.add_translation(resource=cat, pool=None, props=["label"])
    assert getattr(result, "translation") is None

    # empty translation
    cat = Category(
        category_id="foo", type="single_location", label="foo", label_ba=None
    )
    result = await util.add_translation(resource=cat, pool=None, props=["label"])
    assert getattr(result, "translation") is None

    # existing translation
    cat = Category(
        category_id="foo", type="single_location", label="foo", label_ba="bar"
    )
    result = await util.add_translation(resource=cat, pool=None, props=["label"])
    assert getattr(result, "translation") == '{"ba": {"label": "bar"}}'


def test_restore_translation():
    # no translation
    cat = Category(category_id="foo", type="single_location", label="foo")
    result = util.restore_translation(obj=cat)
    assert hasattr(result, "label_ba") == False

    # empty translation
    cat = Category(
        category_id="foo", type="single_location", label="foo", translation="{}"
    )
    result = util.restore_translation(obj=cat)
    assert hasattr(result, "label_ba") == False

    # existing translation
    cat = Category(
        category_id="foo",
        type="single_location",
        label="foo",
        translation='{"ba": {"label": "bar"}}',
    )
    result = util.restore_translation(obj=cat)
    assert getattr(result, "label_ba") == "bar"


def test_serialise_props_list():
    ind = Indicator(
        category_id="foo",
        indicator_id="bar",
        bins=[
            {"min": -3, "max": 3, "width": "10%"},
            {"min": None, "max": -3, "width": "100%"},
            {"min": 3, "max": None, "width": "100%"},
        ],
    )
    result = util.serialise_props(resource=ind, props=["bins"])
    assert (
        getattr(result, "bins")
        == '[{"min": -3.0, "max": 3.0, "width": "10%"}, {"min": null, "max": -3.0, "width": "100%"}, {"min": 3.0, "max": null, "width": "100%"}]'
    )


def test_serialise_props_dict():
    ind = Indicator(category_id="foo", indicator_id="bar", some_dict={"foo": "bar"})
    result = util.serialise_props(resource=ind, props=["some_dict"])
    assert getattr(result, "some_dict") == '{"foo": "bar"}'
