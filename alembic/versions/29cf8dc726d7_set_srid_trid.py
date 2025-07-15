"""set_trid

Revision ID: 29cf8dc726d7
Revises: 3b1f5ed43c14
Create Date: 2025-07-03 16:51:21.868196

"""

from dataclasses import dataclass
from typing import Sequence, Union, Dict
from flowkit_ui_backend.db.const_data import time_id_mapping
from alembic import op, context


# revision identifiers, used by Alembic.
revision: str = "29cf8dc726d7"
down_revision: Union[str, None] = "3b1f5ed43c14"
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    """Upgrade schema."""

    # Not sure that this should live in time_id_mapping - changing it there would
    # affect how the migrations run in the future.
    with_clause = "\n".join(
        f'WHEN label LIKE "{label}" THEN {new_id}'
        for label, new_id in time_id_mapping.items()
    )

    op.execute(
        f"""
            CREATE TEMPORARY TABLE old_new_mapping
              SELECT trid as old_id, label, CASE
              {with_clause}
              END AS new_id
              FROM flowkit_ui_backend.`temporal_resolution`;

            UPDATE flowkit_ui_backend.metadata, old_new_mapping
              SET trid = old_new_mapping.new_id
                WHERE trid = old_new_mapping.old_id;

            UPDATE flowkit_ui_backend.`temporal_resolution`, old_new_mapping
              SET trid = old_new_mapping.new_id
                WHERE trid = old_new_mapping.old_id;
            


    ALTER TABLE flowkit_ui_backend.temporal_resolution DROP COLUMN `id`, ADD PRIMARY KEY(`trid`), MODIFY `trid` INT NOT NULL;

    """
    )


def downgrade() -> None:
    """Downgrade schema."""
    op.execute(
        """
    START TRANSACTION;
    ALTER TABLE flowkit_ui_backend.temporal_resolution ADD COLUMN `id` INT AUTO_INCREMENT UNIQUE FIRST;
    ALTER TABLE flowkit_ui_backend.temporal_resolution DROP PRIMARY KEY;
    ALTER TABLE flowkit_ui_backend.temporal_resolution ADD PRIMARY KEY(`id`); 
    COMMIT;
    """
    )
