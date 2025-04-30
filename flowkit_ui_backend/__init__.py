import os

import structlog

from flowkit_ui_backend.util import logging

default_log_level = "DEBUG" if (int(os.getenv("DEV_MODE", 0)) == 1) else "WARNING"
log_level = os.getenv("LOG_LEVEL", default_log_level)
log_level = log_level.upper()
logging.setup_logging(log_level=log_level, dev_mode=int(os.getenv("DEV_MODE", 0)) == 1)
logger = structlog.get_logger("flowkit_ui_backend.log")
logger.debug(
    f"Using log level {log_level} (default: {default_log_level}, dev mode: {bool(os.getenv('DEV_MODE', 0))})"
)
