# This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

import gzip
import structlog
from typing import Callable
from fastapi import Request, Response
from fastapi.routing import APIRoute


logger = structlog.get_logger("flowkit_ui_backend.log")


# While [the issue](https://github.com/tiangolo/fastapi/issues/1848) is still open,
# we'll use the [example from the docs](https://fastapi.tiangolo.com/advanced/custom-request-and-route/#create-a-custom-gziprequest-class)
class GzipRequest(Request):
    async def body(self) -> bytes:
        if not hasattr(self, "_body"):
            body = await super().body()
            if "gzip" in self.headers.getlist("Content-Encoding"):
                logger.debug("Detected gzip in request body")
                body = gzip.decompress(body)
                logger.debug("Decompressed request body")
                # no need to decode here - the parent handler takes care of that
                # as long as the decoded body is a JSON-encoded python dict
                # if "application/json" in self.headers.getlist("Content-Type"):
                #    body = json.loads(body)

            self._body = body
        return self._body


class GzipRoute(APIRoute):
    def get_route_handler(self) -> Callable:
        original_route_handler = super().get_route_handler()

        async def custom_route_handler(request: Request) -> Response:
            request = GzipRequest(request.scope, request.receive)
            return await original_route_handler(request)

        return custom_route_handler
