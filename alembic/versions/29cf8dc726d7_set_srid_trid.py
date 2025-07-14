"""set_trid

Revision ID: 29cf8dc726d7
Revises: 3b1f5ed43c14
Create Date: 2025-07-03 16:51:21.868196

"""

from dataclasses import dataclass
from typing import Sequence, Union, Dict
from flowkit_ui_backend.db.const_data import time_id_mapping
from alembic import op


# revision identifiers, used by Alembic.
revision: str = "29cf8dc726d7"
down_revision: Union[str, None] = "3b1f5ed43c14"
branch_labels: Union[str, Sequence[str], None] = None
depends_on: Union[str, Sequence[str], None] = None


def upgrade() -> None:
    """Upgrade schema."""

    @dataclass
    class OldNewIdMigration:
        label_mapping: Dict
        id_name: str
        table_name: str

    def make_old_new_id_migration(mig: OldNewIdMigration) -> str:
        with_clause = "\n".join(
            f'WHEN label LIKE "{label}" THEN {new_id}'
            for label, new_id in mig.label_mapping.items()
        )
        return f"""

            WITH old_new_mapping AS (
              SELECT {mig.id_name} as old_id, label, CASE
              {with_clause}
              END AS new_id
              FROM flowkit_ui_backend.`{mig.table_name}`)
            UPDATE flowkit_ui_backend.metadata, old_new_mapping
              SET {mig.id_name} = old_new_mapping.new_id
                WHERE {mig.id_name} = old_new_mapping.old_id;

            WITH old_new_mapping AS (
              SELECT {mig.id_name} as old_id, label, CASE
              {with_clause}
              END AS new_id
              FROM flowkit_ui_backend.`{mig.table_name}`)
            UPDATE flowkit_ui_backend.`{mig.table_name}`, old_new_mapping
              SET {mig.id_name} = old_new_mapping.new_id
                WHERE {mig.id_name} = old_new_mapping.old_id;

            """

    trid_migration = OldNewIdMigration(
        label_mapping=time_id_mapping,
        id_name="trid",
        table_name="temporal_resolution",
    )

    op.execute(
        f"""
            {make_old_new_id_migration(trid_migration)}

    ALTER TABLE flowkit_ui_backend.temporal_resolution MODIFY trid NULLABLE FALSE;
    ALTER TABLE flowkit_ui_backend.temporal_resolution DROP PRIMARY KEY;
    ALTER TABLE flowkit_ui_backend.temporal_resoltuion ADD PRIMARY KEY(`trid`);
    ALTER TABLE flowkit_ui_backend.temporal_resolution DROP COLUMN(`id`);

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
