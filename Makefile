# This Source Code Form is subject to the terms of the Mozilla Public License, v. 2.0.
# If a copy of the MPL was not distributed with this file, You can obtain one at https://mozilla.org/MPL/2.0/.

# Load .env vars
ifneq (,$(wildcard ./.env))
    include .env
    export
endif
ifeq ($(APP_NAME),)
	$(error APP_NAME is not set in the .env file)
endif

MAKEFLAGS+=--always-make # same as declaring all targets phony
SHELL:=/bin/bash # Use bash syntax
UID:=$(shell id -u)
GID:=333
APP_NAME_DB=$(APP_NAME)-db
APP_NAME_TEST=$(APP_NAME)-test
CONTAINER_NAME:=$(APP_NAME)
GIT_COMMIT:=$$(git rev-parse --short HEAD)
# get branch from commit - needs to work even on CI and when checking out tag
GIT_BRANCH:=$$(if [[ -n $$(git branch --show-current) ]]; then git branch --show-current; else git branch -a --contains $$(git rev-parse --short HEAD) | sed '/HEAD/d' | sed 's/remotes\/origin\///g' | sed 's/\*//g' | sed 's/ *//g' | awk '!_[$$0]++'; fi)
GIT_TAG:=$$(git describe --exact-match --tags --abbrev=0 2>/dev/null)
IMAGE_NAME:=flowminder/$(APP_NAME):$$(TAG=$(GIT_TAG) && [[ -n $$TAG ]] && echo $$TAG || echo $(GIT_COMMIT))
IMAGE_NAME_TEST:=$(subst $(APP_NAME),$(APP_NAME_TEST),$(IMAGE_NAME))
PACKAGE_NAME:=$(subst -,_,$(APP_NAME))
APP_DIR:=$(CONTAINER_USER)/$(PACKAGE_NAME)


# tag latest docker image if commit is tagged
ifneq ($(GIT_TAG),)
	DOCKER_LATEST_TAG:=-t flowminder/$(APP_NAME):latest
	DOCKER_LATEST_TAG_TEST:=-t flowminder/$(APP_NAME_TEST):latest
else
	DOCKER_LATEST_TAG:
	DOCKER_LATEST_TAG_TEST:=
endif

# use a bind mount for the impl dir when in dev mode
ifeq ($(DEV_MODE),1)
	VOLUME_IMPL:=$(PWD)/src/impl:/home/$(APP_DIR)/src/impl:rw
	RELOAD:=--reload
	IMAGE_NAME_ACTUAL:=flowminder/$(APP_NAME):latest
else
	VOLUME_IMPL:=/dev/null:/tmp/volume_impl
	RELOAD:=
	IMAGE_NAME_ACTUAL:=$(IMAGE_NAME)
endif
IMAGE_NAME_TEST_ACTUAL:=$(subst $(APP_NAME),$(APP_NAME_TEST),$(IMAGE_NAME_ACTUAL))

# set flag for docker cache
ifeq ($(DOCKER_CACHE_ENABLED),1)
    DOCKER_CACHE_FLAG:=
else
    DOCKER_CACHE_FLAG:=--no-cache
endif

# print jupyter URL if it's running
ifeq ($(JUPYTER_ENABLED),1)
    JUPYTER_TEXT:="Jupyter lab is running on http://127.0.0.1:$(JUPYTER_PORT)/lab?token=jupyter"
	JUPYTER_RUN:=export JUPYTER_PORT=$(JUPYTER_PORT); export CONTAINER_USER=$(CONTAINER_USER); export UID=$(UID); export GID=$(GID); docker compose -p $(APP_NAME) --env-file ./.env up -d jupyter
else
    JUPYTER_TEXT:=
	JUPYTER_RUN:=
endif

# allow running single tests
ifneq ($(TEST_EXPR),)
    SELECTED_TESTS:=-k "$(TEST_EXPR)"
else
    SELECTED_TESTS:=-k 'not skip'
endif

# Fallback for inexistent data dir
ifeq ($(wildcard $(DATA_DIR_LOCAL)/.),)
    $(info Could not find $(DATA_DIR_LOCAL) - using container-internal directory instead)
	DATA_DIR_LOCAL:=
endif

# use a bind mount for the shapefiles dir if a local dir was specified
ifneq ($(DATA_DIR_LOCAL),)
	VOLUME_DATA:=$(DATA_DIR_LOCAL):$(DATA_DIR_CONTAINER):rw
else
	VOLUME_DATA:=/dev/null:/tmp/volume_data
endif

# Don't print verbose output from make target - only print output of commands.

# Targets #####################################################################

# "Help" target as default
all:
	echo -e "No target given. Please use one of these:\n"; \
	echo -e "- \033[1mupgrade\033[0m \tUpgrade the dependencies"; \
	echo -e "- \033[1mdeps\033[0m \t\tRe-generate the dependencies from the *.in files"; \
	echo -e "- \033[1mbuild\033[0m \tBuild the docker image"; \
	echo -e "- \033[1mtest\033[0m \t\tRun all tests in a dedicated container"; \
	echo -e "- \033[1mrun\033[0m \t\tRun the application"; \
	echo -e "- \033[1mingest\033[0m \tIngest data into the database, see src/jupyter/PopulateDatabase.ipynb for details"; \
	echo -e "- \033[1mpop_db\033[0m \t\tPopulates the local db with test data"; \
	echo -e ""; \
	echo -e "API version: $(API_VERSION) (/$(API_VERSION_URL_APPENDIX)); Python version: $(PYTHON_VERSION)"; \
	echo -e "Git info: $(GIT_COMMIT) ($(GIT_BRANCH)); tag: $(GIT_TAG)"; \
	echo -e "Working on docker image $(IMAGE_NAME_ACTUAL)"; \
	echo -e "Matching stash image is $(IMAGE_NAME_DB_ACTUAL)"; \
	echo -e "Matching test image is $(IMAGE_NAME_TEST_ACTUAL)"; \
	echo -e "Local user: $(UID):$(GID) using shell $(SHELL)"; \
	echo -e ""


upgrade:
	docker run --rm \
    --mount "source=${PWD},target=/tmp/requirements,type=bind" \
    shakiyam/pip-tools@sha256:5864eb067c68ee679240e6bea9aa7cdde8b42bbe4410e028b9eaefbc0d65a62c pip-compile \
    --upgrade --output-file=/tmp/requirements/requirements.txt /tmp/requirements/requirements.in
	docker run --rm \
    --mount "source=${PWD},target=/tmp/requirements,type=bind" \
    shakiyam/pip-tools@sha256:5864eb067c68ee679240e6bea9aa7cdde8b42bbe4410e028b9eaefbc0d65a62c pip-compile \
    --upgrade --output-file=/tmp/requirements/dev-requirements.txt /tmp/requirements/dev-requirements.in
	

deps:
	docker run --rm \
    --mount "source=${PWD},target=/tmp/requirements,type=bind" \
    shakiyam/pip-tools@sha256:5864eb067c68ee679240e6bea9aa7cdde8b42bbe4410e028b9eaefbc0d65a62c pip-compile \
    --output-file=/tmp/requirements/requirements.txt /tmp/requirements/requirements.in
	docker run --rm \
    --mount "source=${PWD},target=/tmp/requirements,type=bind" \
    shakiyam/pip-tools@sha256:5864eb067c68ee679240e6bea9aa7cdde8b42bbe4410e028b9eaefbc0d65a62c pip-compile \
    --output-file=/tmp/requirements/dev-requirements.txt /tmp/requirements/dev-requirements.in


build: export API_VERSION=${GIT_TAG}
build: export GIT_BRANCH?=
build: export GIT_COMMIT?=
build: export GIT_TAG?=
build:
	$(info Running build...)
	echo "Building docker image $(IMAGE_NAME)..."
	docker build --rm \
	--target prod \
	--build-arg API_VERSION=$(API_VERSION) \
	--build-arg GIT_BRANCH=$(GIT_BRANCH) \
	--build-arg GIT_COMMIT=$(GIT_COMMIT) \
	--build-arg GIT_TAG=$(GIT_TAG) \
	--build-arg APP_NAME=$(APP_NAME) \
	--build-arg IMAGE_NAME=$(IMAGE_NAME) \
	-f ./Dockerfile $(DOCKER_CACHE_FLAG) \
	-t $(IMAGE_NAME) $(DOCKER_LATEST_TAG) .
	echo "Done. Built docker image \"$(IMAGE_NAME)\" for API version $(API_VERSION)."

run-db:
	docker compose -f docker-compose-mysql.yml --env-file ./development_env up -d --always-recreate-deps db
	while [ $$(docker inspect --format "{{json .State.Health.Status }}" $(CONTAINER_NAME_DB)) != "\"healthy\"" ]; do echo "Waiting for db..."; sleep 1; done

test: export API_VERSION=${GIT_TAG}
test: export GIT_BRANCH?=
test: export GIT_COMMIT?=
test: export GIT_TAG?=
test: run-db
	source .venv/bin/activate; python -m pytest $(SELECTED_TESTS) \
		--disable-pytest-warnings -p no:warnings -vvvv \
		-o log_cli=false --show-capture=all \
		--cov-config=.coveragerc \
		--cov=$(PACKAGE_NAME) \
		--cov-report term-missing \
		--cov-report xml:./test_results/coverage.xml \
		--junit-xml=./test_results/results.xml \
		tests; \
	ERR=$$?; \
	docker compose -f docker-compose-mysql.yml logs ;\
	docker compose -f docker-compose-mysql.yml down ;\
	exit $$ERR

clear: 
	$(info Clearing old containers...)
	docker compose -p $(APP_NAME) down ;\
	docker compose -f docker-compose-mysql.yml down

run: run-db
run:
	$(info Running application...)
	echo "Starting $(APP_NAME) dev server docker container \"$(CONTAINER_NAME)\" on http://localhost:$(SERVER_PORT_HOST)$(API_VERSION_URL_APPENDIX)/heartbeat..."
	echo "Find the API docs on http://localhost:$(SERVER_PORT_HOST)/docs or http://localhost:$(SERVER_PORT_HOST)/redoc"
	echo "or download the API spec directly from http://localhost:$(SERVER_PORT_HOST)/openapi.json"
	echo $(JUPYTER_TEXT)
	$(JUPYTER_RUN)
	export IMAGE_NAME_ACTUAL=$(IMAGE_NAME_ACTUAL); \
	docker compose -p $(APP_NAME) --env-file ./.env run --name $(APP_NAME) --service-ports web

ingest:
	$(info Running ingestion script to populate database...)
	export JUPYTER_PORT=$(JUPYTER_PORT); export CONTAINER_USER=$(CONTAINER_USER); export UID=$(UID); export GID=$(GID); docker compose -p $(APP_NAME) --env-file ./.env run jupyter bash -c "pip install httpx pandas; cd /home/$(CONTAINER_USER); jupyter nbconvert --to script PopulateDatabase.ipynb; cat PopulateDatabase.py | grep -v get_ipython > run.py; python run.py; rm PopulateDatabase.py run.py"

lint:
	$(info Linting source code...)
	docker compose -p $(APP_NAME)_lint down
	export IMAGE_NAME_ACTUAL=$(IMAGE_NAME_ACTUAL); \
	docker compose -p $(APP_NAME)_lint --env-file ./.env run --name $(APP_NAME)_lint --service-ports --entrypoint="" web bash -c \
	"pip install black; black /home/$(APP_DIR)/src/impl"

pop_db:
	$(info Populating local db for testing)
	docker cp ./src/impl/tests/test_data.sql $(CONTAINER_NAME_DB):/test_data.sql
	docker exec -it $(CONTAINER_NAME_DB) mysql -u$(DB_USER) -p$(DB_PW) -e "source /test_data.sql" $(DB_NAME)

stop: clear
	$(info Shutting down...)
