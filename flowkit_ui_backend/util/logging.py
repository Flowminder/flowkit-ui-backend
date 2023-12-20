# This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

import structlog
import logging.config
from asgi_correlation_id import correlation_id
from flowkit_ui_backend.util.structlog.dev import ConsoleRenderer
from typing import Tuple, Any


def add_correlation(
    logger: logging.Logger, method_name: str, event_dict: dict[str, Any]
) -> dict[str, Any]:
    """Add request id to log message."""
    if request_id := correlation_id.get():
        event_dict["request_id"] = request_id
    return event_dict


def setup_logging(log_level: str = "INFO", dev_mode: bool = False) -> None:
    """
    Configure structured logging

    Parameters
    ----------
    log_level : str, default 'INFO'
    dev_mode : bool, default False
        Set to true to use coloured logs and enhanced exception formatting, disables json formatting
    """

    if dev_mode:
        processors: Tuple[flowkit_ui_backend.util.structlog.types.Processor, ...] = (
            add_correlation,
            structlog.processors.TimeStamper(fmt="%H:%M:%S.%f"),
            structlog.stdlib.add_log_level,
            structlog.processors.CallsiteParameterAdder(
                [
                    structlog.processors.CallsiteParameter.FILENAME,
                    structlog.processors.CallsiteParameter.FUNC_NAME,
                    structlog.processors.CallsiteParameter.LINENO,
                ]
            ),
        )

    else:
        processors: Tuple[flowkit_ui_backend.util.structlog.types.Processor, ...] = (
            add_correlation,
            structlog.contextvars.merge_contextvars,
            structlog.processors.TimeStamper(fmt="iso"),
            structlog.stdlib.add_logger_name,
            structlog.stdlib.add_log_level,
            structlog.processors.CallsiteParameterAdder(
                [
                    structlog.processors.CallsiteParameter.MODULE,
                    structlog.processors.CallsiteParameter.PATHNAME,
                    structlog.processors.CallsiteParameter.FILENAME,
                    structlog.processors.CallsiteParameter.FUNC_NAME,
                    structlog.processors.CallsiteParameter.LINENO,
                ]
            ),
        )

    formatter = "console" if dev_mode else "json"
    logging_config = {
        "version": 1,
        "disable_existing_loggers": False,
        "formatters": {
            "json": {
                "()": structlog.stdlib.ProcessorFormatter,
                "processor": structlog.processors.JSONRenderer(),
                "foreign_pre_chain": processors,
            },
            "console": {
                "()": structlog.stdlib.ProcessorFormatter,
                "processor": ConsoleRenderer(
                    # see https://stackoverflow.com/questions/4842424/list-of-ansi-color-escape-sequences
                    level_styles={
                        "critical": "\x1b[41m\x1b[37m",
                        "exception": "\x1b[31m",
                        "error": "\x1b[31m",
                        "warn": "\033[38;5;214m",
                        "warning": "\033[38;5;214m",
                        "info": "\x1b[32m",
                        "debug": "\033[38;5;240m",
                        "notset": "\x1b[41m",
                    },
                ),
                "foreign_pre_chain": processors,
            },
        },
        "handlers": {
            "default": {
                "level": "DEBUG",
                "class": "logging.StreamHandler",
                "formatter": formatter,
            },
            "uvicorn.access": {
                "level": "INFO",
                "class": "logging.StreamHandler",
                "formatter": formatter,
            },
            "uvicorn.default": {
                "level": "INFO",
                "class": "logging.StreamHandler",
                "formatter": formatter,
            },
        },
        "loggers": {
            "": {"handlers": ["default"], "level": log_level},
            "uvicorn": {
                "handlers": ["uvicorn.default"],
                "level": "INFO",
                "propagate": False,
            },
            "uvicorn.error": {
                "handlers": ["uvicorn.default"],
                "level": "INFO",
                "propagate": False,
            },
            "uvicorn.access": {
                "handlers": ["uvicorn.access"],
                "level": "INFO",
                "propagate": False,
            },
        },
    }
    structlog.configure(
        processors=[
            structlog.stdlib.filter_by_level,
            *processors,
            structlog.stdlib.PositionalArgumentsFormatter(),
            structlog.processors.StackInfoRenderer(),
            structlog.processors.format_exc_info,
            structlog.stdlib.ProcessorFormatter.wrap_for_formatter,
        ],
        context_class=dict,
        logger_factory=structlog.stdlib.LoggerFactory(),
        wrapper_class=structlog.stdlib.BoundLogger,
        cache_logger_on_first_use=True,
    )
    logging.config.dictConfig(logging_config)
