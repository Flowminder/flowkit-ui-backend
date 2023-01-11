[![Code style: black](https://img.shields.io/badge/code%20style-black-000000.svg)](https://github.com/psf/black)
[![CircleCI](https://circleci.com/gh/Flowminder/flowkit-ui-backend/tree/main.svg?style=shield&circle-token=796b4bc41e57655a4779f8d112f8985557668385)](https://circleci.com/gh/Flowminder/flowkit-ui-backend/tree/dev)
[![OpenAPI spec](https://img.shields.io/badge/OpenAPI_spec-online-brightgreen)](https://flowminder.github.io/flowkit-ui-backend)
[![codecov](https://codecov.io/gh/Flowminder/flowkit-ui-backend/branch/main/graph/badge.svg?token=RBS8T58USO)](https://codecov.io/gh/Flowminder/flowkit-ui-backend)

# FlowKit-UI backend

A Flowkit query postprocessing, data management and authentication/authorisation component

## Requirements

The tool itself is containerised, so as long as you have Docker installed, it will take care of its own dependencies inside its container(s).

To build/run:

-   Docker
-   Make

To commit:

-   [pre-commit](https://pre-commit.com/) (for commit hooks)

## Getting started

Run the app via `make`. The following command will give you an overview of available targets:

```console
make
```

You can use the following targets:

-   `doc`: generate docs, from API spec; to be found at `./doc`
-   `code`: generate code from API spec; to be found at `./src-generated`
-   `build`:
    -   generate code and docs using the OpenAPI spec at `src/api.json`
    -   link the implementation code into the generated code
    -   build a new docker image (i.e. use the latest API spec)
-   `test`: run all unit tests and produce a coverage report
-   `run`: start the image, using the implementation directory as a bind mount (i.e. changes will be reflected by the flask server on the next API call)

Access the API at [http://localhost:5000](http://localhost:5000).
The API document can be viewed at [http://localhost:5000/openapi.json](http://localhost:5000/openapi.json).

## Workflow

### Changing the API

This requires you to update the `src/api.json` file.
This file is the **single source of truth** and should be the place that contains the API spec and documentation.

Once you're happy, you need to make sure that any endpoints as defined in the spec are reflected in the implementation (located at `src/impl/controllers`).
Each category of endpoints (using OpenAPI's "tag" feature) will require a separate file. So if you tag is e.g. `general` then the file needs to be called `general_controller_impl.py`.

Each `controller_impl.py` file is just a collection of methods representing the implementation of each endpoint.
No class is needed; the only requirement is that the controller implementation function uses

-   the same name AND
-   the same name and number and types of arguments

as the endpoint. There is no need to add pydoc comments to each function - all documentation lives in the API spec. The only comments you should add are regular in-code comments where necessary. See the example below:

```python
def heartbeat():
    # This is printed out by the server
    print("Request received, checking heartbeat...")

    # Returned response to the client who called the endpoint
    if is_alive:
        # HTTP status: OK
        return "beep-beep-beep", HTTPStatus.OK
    else:
        # HTTP status: gone
        return "beeeeeeeeeeeep", HTTPStatus.GONE
```

### Changing the implementation

When running a docker container locally, the web server is running in development mode.
Since we never copied the implementation code onto the container but linked it in as a volume instead, you can just edit the implementation files in `src/impl`. After you save the file, any changes will be picked up by the web server automatically. So after you resend the API request (e.g. by refreshing your page), the updated version is used.

If you need to add any dependencies, add them to `src/impl/requirements.txt` and refer to the section above as the docker image will have to be rebuilt.

## Deployment

**TODO**
