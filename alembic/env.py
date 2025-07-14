from pathlib import Path
from logging.config import fileConfig
from dataclasses import asdict, dataclass

from urllib.parse import quote_plus
from sqlalchemy import create_engine


from alembic import context

# this is the Alembic Config object, which provides
# access to the values within the .ini file in use.
config = context.config

# Interpret the config file for Python logging.
# This line sets up loggers basically.
if config.config_file_name is not None:
    fileConfig(config.config_file_name)

# add your model's MetaData object here
# for 'autogenerate' support
# from myapp import mymodel
# target_metadata = mymodel.Base.metadata
target_metadata = None

# other values from the config, defined by the needs of env.py,
# can be acquired:
# my_important_option = config.get_main_option("my_important_option")
# ... etc.


@dataclass
class ConnectionSpec:
    user: str
    password: str
    db_name: str
    port: int
    host: str


def build_url_from_spec(spec: ConnectionSpec) -> str:
    url = f"mysql+mysqldb://{spec.user}:{spec.password}@{spec.host}:{spec.port}/{spec.db_name}"
    return url


def spec_from_file(file: Path) -> ConnectionSpec:
    env = {
        line.split("=")[0]: quote_plus(line.split("=")[1].strip())
        for line in file.open().readlines()
    }
    return ConnectionSpec(
        user=env["DB_USER"],
        password=env["DB_PW"],
        db_name=env["DB_NAME"],
        port=int(env["PORT"]),
        host=env["HOST"],
    )


def spec_for_local() -> ConnectionSpec:
    dev_cred_file = Path(__file__).parent / "local_credentials"
    return spec_from_file(dev_cred_file)


def spec_for_remote() -> ConnectionSpec:
    print("Caution: running migration on remote db")
    dev_cred_file = Path(__file__).parent / "dev_credentials"
    return spec_from_file(dev_cred_file)


def run_migrations_offline(spec: ConnectionSpec) -> None:
    """Run migrations in 'offline' mode.

    This configures the context with just a URL
    and not an Engine, though an Engine is acceptable
    here as well.  By skipping the Engine creation
    we don't even need a DBAPI to be available.

    Calls to context.execute() here emit the given string to the
    script output.

    """
    context.configure(
        url=build_url_from_spec(spec),
        target_metadata=target_metadata,
        literal_binds=True,
        dialect_opts={"paramstyle": "named"},
    )

    with context.begin_transaction():
        context.run_migrations()


def run_migrations_online(spec: ConnectionSpec) -> None:
    """Run migrations in 'online' mode.

    In this scenario we need to create an Engine
    and associate a connection with the context.

    """
    connectable = create_engine(build_url_from_spec(spec))

    with connectable.connect() as connection:
        context.configure(connection=connection, target_metadata=target_metadata)

        with context.begin_transaction():
            context.run_migrations()


# Safty barrier - explicitly switch this when you're working on
# remote tables
spec = spec_for_local()
# spec = spec_for_remote()

if context.is_offline_mode():
    run_migrations_offline(spec)
else:
    run_migrations_online(spec)
