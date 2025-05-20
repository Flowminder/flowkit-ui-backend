# This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

FROM python:3.12-slim as prod

# start as root
USER root


# install os-level dependencies & set up dedicated user for this container
RUN apt-get update && \
    apt-get install -y --no-install-recommends python3-pip build-essential && \
    rm -rf /var/lib/apt/lists/* && \
    python -m pip install --upgrade pip && \
    pip cache purge && \
    groupadd -g 333 hamster && \
    useradd --no-log-init -g 333 -u 501 hamster && \
    mkdir -p /home/hamster/flowkit_ui_backend && \
    chown -R hamster:hamster /home/hamster && \
    mkdir -m 777 -p "/home/hamster/data" && \
    chown -R hamster:hamster "/home/hamster/data"

# install impl python libraries for this user only
# do this now as they don't change often so the build can use caching
USER hamster

# make sure user's python libs can be used later
ENV PATH="${PATH}:/home/hamster/.local/bin"

# install python libraries for this user only
COPY ./requirements.txt /tmp/requirements.txt

RUN pip install --no-cache-dir -r /tmp/requirements.txt  && pip cache purge

# copy all files to the container and make our user own them
COPY --chown=hamster:hamster ./flowkit_ui_backend /home/hamster/flowkit_ui_backend

# run the actual (generated) app inside its directory
WORKDIR /home/hamster

ENV PYTHONPATH="${PYTHONPATH}:/home/hamster/flowkit_ui_backend"

ENTRYPOINT ["uvicorn" , "flowkit_ui_backend.main:app", "--host", "0.0.0.0", "--port",  "5000"]

ARG IMAGE_NAME
ARG GIT_BRANCH
ARG GIT_COMMIT
ARG GIT_TAG
ARG API_VERSION
ARG APP_NAME=flowkit-ui-backend
ENV API_VERSION=$API_VERSION
ENV IMAGE_NAME=$IMAGE_NAME
ENV GIT_BRANCH=$GIT_BRANCH
ENV GIT_COMMIT=$GIT_COMMIT
ENV GIT_TAG=$GIT_TAG
ENV API_VERSION_URL_APPENDIX="/v1"
ENV APP_NAME=$APP_NAME
ENV JUPYTER_PORT=8888
ENV JUPYTER_ENABLED=0
ENV SECURE_FILE_BUCKET=$SECURE_FILE_BUCKET
ENV DQS_BUCKET_PATH=$DQS_BUCKET_PATH
