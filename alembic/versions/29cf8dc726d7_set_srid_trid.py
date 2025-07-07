"""set_srid_trid

Revision ID: 29cf8dc726d7
Revises: 3b1f5ed43c14
Create Date: 2025-07-03 16:51:21.868196

"""
from typing import Sequence, Union

from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision: str = '29cf8dc726d7'
down_revision: Union[str, None] = '3b1f5ed43c14'
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    """Upgrade schema."""
    pass


def downgrade() -> None:
    """Downgrade schema."""
    pass
