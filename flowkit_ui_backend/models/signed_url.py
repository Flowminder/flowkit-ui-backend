

from pydantic import BaseModel


class SignedUrl(BaseModel):
    url: str
    file_name: str

SignedUrl.update_forward_refs()