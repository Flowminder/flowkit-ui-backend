"""base

Revision ID: 3b1f5ed43c14
Revises:
Create Date: 2025-06-24 16:07:35.332513

"""

from typing import Sequence, Union
from pathlib import Path

from alembic import op, context
from aiomysql import create_pool
from flowkit_ui_backend.db.db import SCHEMA_PATH


# revision identifiers, used by Alembic.
revision: str = "3b1f5ed43c14"
down_revision: Union[str, None] = None
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    """Upgrade is a misnomer - this provisions the db"""
    schema_query = Path(SCHEMA_PATH).read_text()

    op.execute(schema_query)
