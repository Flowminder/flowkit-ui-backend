# This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

import os
from flowkit_ui_backend.impl.util import db


def pytest_sessionstart(session):
    db.run_script(
        f"/home/{os.getenv('CONTAINER_USER')}/{os.getenv('PACKAGE_NAME')}/src-generated/schema/mysql_schema.sql"
    )
