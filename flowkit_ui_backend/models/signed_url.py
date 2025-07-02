from pydantic.v1 import BaseModel


class SignedUrl(BaseModel):
    url: str
    file_name: str


SignedUrl.update_forward_refs()
