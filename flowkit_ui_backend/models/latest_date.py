from pydantic import BaseModel
from datetime import date


class LatestDate(BaseModel):
    latest_date: date


