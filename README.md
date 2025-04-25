[![Code style: black](https://img.shields.io/badge/code%20style-black-000000.svg)](https://github.com/psf/black)
[![CircleCI](https://circleci.com/gh/Flowminder/flowkit-ui-backend/tree/main.svg?style=shield&circle-token=796b4bc41e57655a4779f8d112f8985557668385)](https://circleci.com/gh/Flowminder/flowkit-ui-backend/tree/dev)
[![OpenAPI spec](https://img.shields.io/badge/OpenAPI_spec-online-brightgreen)](https://flowminder.github.io/flowkit-ui-backend)
[![codecov](https://codecov.io/gh/Flowminder/flowkit-ui-backend/branch/main/graph/badge.svg?token=RBS8T58USO)](https://codecov.io/gh/Flowminder/flowkit-ui-backend)

# FlowKit-UI backend

A [Flowkit](https://github.com/Flowminder/Flowkit) query postprocessing, data management and authentication/authorisation component, designed for use with [Flowminder/flowkit-ui](https://github.com/Flowminder/flowkit-ui).

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

-   `deps`: Regenerate pinned requirements.txt files
-   `build`: build a new docker image (i.e. use the latest API spec)
-   `test`: run all unit tests and produce a coverage report
-   `run`: start the image, using the implementation directory as a bind mount (i.e. changes will be reflected by the flask server on the next API call)

Access the API at [http://localhost:5000](http://localhost:5000).
The API document can be viewed at [http://localhost:5000/openapi.json](http://localhost:5000/openapi.json).

## Adding new dependencies

If you need to add any dependencies, add them to `src/impl/requirements.in` or `src/impl/dev-requirements.in` and refer to the section above as the docker image will have to be rebuilt.

## Building without make

### Build Args

- API_VERSION
- API_VERSION_URL_APPENDIX
- GIT_BRANCH
- GIT_COMMIT
- GIT_TAG
- APP_NAME
- IMAGE_NAME

### Running a non-containerised web backend

``` bash
 $ docker compose --env-file development_env up db
 $ python -m uvicorn --env-file development_env flowkit_ui_backend.main:app --host 0.0.0.0 --port 5000 --reload
 $ mysql -uhamster -hlocalhost -Dflowkit_ui_backend -P3306 --protocol=tcp -pTEST_PASSWORD 
 $ mysql -uhamster -hlocalhost -Dflowkit_ui_backend -P3306 --protocol=tcp -pTEST_PASSWORD < flowkit_ui_backend/db/mysql_schema.sql 
 $ mysql -uhamster -hlocalhost -Dflowkit_ui_backend -P3306 --protocol=tcp -pTEST_PASSWORD < tests/test_data.sql 
```


### Required env vars

* DB_NAME
* DB_PORT_CONTAINER
* DB_PW
* DB_USER
* FLOWKIT_UI_URL
* CONTAINER_NAME_DB
* SERVER_PORT_HOST
* AUTH0_DOMAIN
* AUTH0_CLIENT_ID
* AUTH0_CLIENT_SECRET
* AUTH0_AUDIENCE

### Optional env vars

* DEV_MODE (default 0, set to 1 to enable)
* LOG_LEVEL (default to warning, default to debug if DEV_MODE=1)
* JUPYTER_ENABLED (default 0, set to 1 if using jupyter locally)
* JUPYTER_PORT
