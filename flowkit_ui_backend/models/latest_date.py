from pydantic.v1 import BaseModel
from datetime import date


class LatestDate(BaseModel):
    latest_date: date
