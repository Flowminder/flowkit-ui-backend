"""base

Revision ID: 3b1f5ed43c14
Revises:
Create Date: 2025-06-24 16:07:35.332513

"""

from typing import Sequence, Union

from alembic import op, context
import sqlalchemy as sa
from aiomysql import create_pool
from flowkit_ui_backend.db.db import provision_db


# revision identifiers, used by Alembic.
revision: str = "3b1f5ed43c14"
down_revision: Union[str, None] = None
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    """Upgrade is a misnomer - this provisions the db"""
    attrs = context.config.attributes
    pool = create_pool(
        maxsize=1,
        host=attrs["host"],
        user=attrs["user"],
        password=attrs["password"],
        db=attrs["db"],
        port=attrs["port"],
    )
    op.run_async(provision_db(pool))
    pass
