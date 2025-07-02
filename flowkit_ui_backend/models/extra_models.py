# coding: utf-8

from typing import List
from pydantic.v1 import BaseModel


class TokenModel(BaseModel):
    """Defines a token model."""

    sub: str
    permissions: List[str]
