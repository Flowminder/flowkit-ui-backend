"""set_srid_trid

Revision ID: 29cf8dc726d7
Revises: 3b1f5ed43c14
Create Date: 2025-07-03 16:51:21.868196

"""

from dataclasses import dataclass
from typing import Sequence, Union, Dict

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
            START TRANSACTION;

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

            COMMIT;
            """

    srid_migration = OldNewIdMigration(
        label_mapping={"Department": 1, "Commune": 2, "Communal section": 3},
        id_name="srid",
        table_name="spatial_resolution",
    )

    trid_migration = OldNewIdMigration(
        label_mapping={"Year": 1, "Month": 2, "Week": 3, "Day": 4},
        id_name="trid",
        table_name="temporal_resolution",
    )

    op.execute(make_old_new_id_migration(srid_migration))
    op.execute(make_old_new_id_migration(trid_migration))


def downgrade() -> None:
    """Downgrade schema."""
    # No downgrade, as there is no way of saving the previous srids or trids
    pass
