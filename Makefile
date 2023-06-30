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
API_VERSION:=$$(cat ./src/api.json | grep \"version\": | sed 's/"//g' | sed 's/version://g' | sed 's/ //g' | sed 's/,//g')
API_VERSION_URL_APPENDIX:=$$(cat ./src/api.json | grep "\"url\":.*localhost.*/v." | sed 's/^.*\///' | sed 's/\",//')
LOCAL_URL:=$$(cat ./src/api.json | grep "\"url\":.*localhost": | sed 's/"//g' | sed 's/url://g' | sed 's/ //g' | sed 's/,//g')
APP_NAME_DB=$(APP_NAME)-db
APP_NAME_TEST=$(APP_NAME)-test
CONTAINER_NAME:=$(APP_NAME)
CONTAINER_NAME_DB:=$(APP_NAME_DB)
GIT_COMMIT:=$$(git rev-parse --short HEAD)
# get branch from commit - needs to work even on CI and when checking out tag
GIT_BRANCH:=$$(if [[ -n $$(git branch --show-current) ]]; then git branch --show-current; else git branch -a --contains $$(git rev-parse --short HEAD) | sed '/HEAD/d' | sed 's/remotes\/origin\///g' | sed 's/\*//g' | sed 's/ *//g' | awk '!_[$$0]++'; fi)
GIT_TAG:=$$(git describe --exact-match --tags --abbrev=0 2>/dev/null)
IMAGE_NAME:=flowminder/$(APP_NAME):$$(TAG=$(GIT_TAG) && [[ -n $$TAG ]] && echo $$TAG || echo $(GIT_COMMIT))
IMAGE_NAME_DB:=$(subst $(APP_NAME),$(APP_NAME_DB),$(IMAGE_NAME))
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
IMAGE_NAME_DB_ACTUAL:=$(subst $(APP_NAME),$(APP_NAME_DB),$(IMAGE_NAME_ACTUAL))
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
.SILENT:

# Targets #####################################################################

# "Help" target as default
all:
	echo -e "No target given. Please use one of these:\n"; \
	echo -e "- \033[1mupgrade\033[0m \tUpgrade the dependencies"; \
	echo -e "- \033[1mdeps\033[0m \t\tRe-generate the dependencies from the *.in files"; \
	echo -e "- \033[1mcode\033[0m \t\tGenerate the code"; \
	echo -e "- \033[1mbuild\033[0m \tBuild the docker image"; \
	echo -e "- \033[1mtest\033[0m \t\tRun all tests in a dedicated container"; \
	echo -e "- \033[1mrun\033[0m \t\tRun the application"; \
	echo -e "- \033[1mingest\033[0m \tIngest data into the database, see src/jupyter/PopulateDatabase.ipynb for details"; \
	echo -e ""; \
	echo -e "API version: $(API_VERSION) (/$(API_VERSION_URL_APPENDIX)); Python version: $(PYTHON_VERSION)"; \
	echo -e "Git info: $(GIT_COMMIT) ($(GIT_BRANCH)); tag: $(GIT_TAG)"; \
	echo -e "Working on docker image $(IMAGE_NAME_ACTUAL)"; \
	echo -e "Matching stash image is $(IMAGE_NAME_DB_ACTUAL)"; \
	echo -e "Matching test image is $(IMAGE_NAME_TEST_ACTUAL)"; \
	echo -e "Local user: $(UID):$(GID) using shell $(SHELL)"; \
	echo -e ""

--clean: --codeclean
	$(info Cleaning tmp files...)

--codeclean:
	$(info Cleaning generated code...)
	rm -rf ./src-generated
	echo "Done."

--validate-api:
	$(info Validating API spec...)
	docker run --rm --volume "$(PWD)":/data jamescooke/openapi-validator:0.97.3 -v -s -r .spectral.yaml ./src/api.json

--codegen: --codeclean --validate-api
	$(info Generating code from API spec...)
	echo "Current working directory: $(PWD)"
	docker run --rm -v "$(PWD):/tmp/code" \
	-u "$(UID):$(GID)" \
	-e JAVA_OPTS="-Xmx15G -DloggerPath=conf/log4j.properties" \
	openapitools/openapi-generator-cli:v6.2.0 generate \
	-g python-fastapi \
	-i /tmp/code/src/api.json \
	-o /tmp/code/src-generated \
	-t /tmp/code/codegen/templates/fastapi \
	-p pythonVersion=$(PYTHON_VERSION) \
	-p packageName=$(PACKAGE_NAME) \
	-p packageVersion=$(APP_VERSION) \
	-p serverPort=$(SERVER_PORT_CONTAINER) \
	-p user=$(CONTAINER_USER) \
	-p uid=$${UID:-9001} -p gid=$${GID:-9001} \
	-p dataDir=$(DATA_DIR_CONTAINER) \
	--skip-validate-spec --global-property debugOperations=true>codegen-server.log;
	docker run --rm -v "$(PWD):/tmp/code" \
	-u "$(UID):$(GID)" \
	openapitools/openapi-generator-cli generate \
	-g mysql-schema \
	-i /tmp/code/src/api.json \
	-o /tmp/code/src-generated/schema \
	-t /tmp/code/codegen/templates/mysql \
	-p defaultDatabaseName=$(DB_NAME) \
	--skip-validate-spec --global-property debugModels=true>codegen-schema.log;
	echo "Done. Please find your code at $(PWD)/src-generated"

code: --codegen

upgrade:
	docker run --rm \
    --mount "source=${PWD}/src/impl,target=/tmp/requirements,type=bind" \
    shakiyam/pip-tools@sha256:5864eb067c68ee679240e6bea9aa7cdde8b42bbe4410e028b9eaefbc0d65a62c pip-compile \
    --upgrade --output-file=/tmp/requirements/requirements.txt /tmp/requirements/requirements.in
	docker run --rm \
    --mount "source=${PWD}/src/impl,target=/tmp/requirements,type=bind" \
    shakiyam/pip-tools@sha256:5864eb067c68ee679240e6bea9aa7cdde8b42bbe4410e028b9eaefbc0d65a62c pip-compile \
    --upgrade --output-file=/tmp/requirements/dev-requirements.txt /tmp/requirements/dev-requirements.in
	

deps:
	docker run --rm \
    --mount "source=${PWD}/src/impl,target=/tmp/requirements,type=bind" \
    shakiyam/pip-tools@sha256:5864eb067c68ee679240e6bea9aa7cdde8b42bbe4410e028b9eaefbc0d65a62c pip-compile \
    --output-file=/tmp/requirements/requirements.txt /tmp/requirements/requirements.in
	docker run --rm \
    --mount "source=${PWD}/src/impl,target=/tmp/requirements,type=bind" \
    shakiyam/pip-tools@sha256:5864eb067c68ee679240e6bea9aa7cdde8b42bbe4410e028b9eaefbc0d65a62c pip-compile \
    --output-file=/tmp/requirements/dev-requirements.txt /tmp/requirements/dev-requirements.in


build: --clean --codegen
	$(info Running build...)
	echo "Copying required files into generated code..."
	cp ./src/.coveragerc ./src-generated/.coveragerc
	cp ./src/impl/requirements.txt ./src-generated/requirements.txt
	cp ./src/impl/dev-requirements.txt ./src-generated/dev-requirements.txt
	cp ./.env ./src-generated/.env
	echo "Linking generated code to implementation..." 
	ln -s ../../../src/impl/ ./src-generated/src/$(PACKAGE_NAME)
	TEXT="# Generated during build ##########################################################################\n" && \
	TEXT="$${TEXT}API_VERSION=${API_VERSION}\nAPI_VERSION_URL_APPENDIX=${API_VERSION_URL_APPENDIX}\n" && \
	TEXT="$${TEXT}GIT_BRANCH=${GIT_BRANCH}\nGIT_COMMIT=${GIT_COMMIT}\nGIT_TAG=${GIT_TAG}\nIMAGE_NAME=${IMAGE_NAME}" && \
	echo -e $$TEXT >> ./src-generated/.env
	echo "Building docker image $(IMAGE_NAME)..."
	docker build --rm \
	--target prod \
	-f ./src-generated/Dockerfile $(DOCKER_CACHE_FLAG) \
	-t $(IMAGE_NAME) $(DOCKER_LATEST_TAG) .
	echo "Building tests image $(IMAGE_NAME_TEST)..."
	docker build --rm \
	--target test \
	-f ./src-generated/Dockerfile $(DOCKER_CACHE_FLAG) \
	-t $(IMAGE_NAME_TEST) $(DOCKER_LATEST_TAG_TEST) .
	docker build --rm \
	-f ./src/stash.Dockerfile $(DOCKER_CACHE_FLAG) \
	-t $(IMAGE_NAME_DB) $(subst $(APP_NAME),$(APP_NAME_DB),$(DOCKER_LATEST_TAG)) .
	echo "Done. Built docker images \"$(IMAGE_NAME)\", \"$(IMAGE_NAME_TEST)\" and \"$(IMAGE_NAME_DB)\" for API version $(API_VERSION)."

test:
	$(eval CONTAINER_NAME:=$(CONTAINER_NAME)_test)
	$(eval CONTAINER_NAME_DB:=$(CONTAINER_NAME_DB)_test)
	$(eval SERVER_PORT_HOST:=$(shell echo $$(($(SERVER_PORT_HOST)+1))))
	$(eval DB_PORT_HOST:=$(shell echo $$(($(DB_PORT_HOST)+1))))
	export IMAGE_NAME_DB_ACTUAL=$(IMAGE_NAME_DB_ACTUAL); \
		docker compose -p $(APP_NAME_TEST) --env-file ./.env up -d --always-recreate-deps db
	while [ $$(docker inspect --format "{{json .State.Health.Status }}" $(CONTAINER_NAME_DB)) != "\"healthy\"" ]; do echo "Waiting for db..."; sleep 1; done
		export IMAGE_NAME_ACTUAL=$(IMAGE_NAME_TEST_ACTUAL); \
		docker compose -p $(APP_NAME_TEST) --env-file ./.env run web \
			"python -m pytest $(SELECTED_TESTS) \
			--disable-pytest-warnings -p no:warnings -vvvv \
			-o log_cli=false --show-capture=all \
			--cov-config=/home/$(APP_DIR)/.coveragerc \
			--cov=$(PACKAGE_NAME) \
			--cov-report term-missing \
			--cov-report xml:/home/$(APP_DIR)/test_results/coverage.xml \
			--junit-xml=/home/$(APP_DIR)/test_results/results.xml \
			/home/$(APP_DIR)/src-generated/tests /home/$(APP_DIR)/src-generated/src/$(PACKAGE_NAME)/impl/tests"; \
		ERR=$$?; \
		docker compose -p $(APP_NAME_TEST) down ;\
		exit $$ERR

clear: 
	$(info Clearing old containers...)
	docker compose -p $(APP_NAME) down

run: clear
	$(info Running application...)
	echo "Starting $(APP_NAME) dev server docker container \"$(CONTAINER_NAME)\" on http://localhost:$(SERVER_PORT_HOST)/$(API_VERSION_URL_APPENDIX)/heartbeat..."
	echo "Find the API docs on http://localhost:$(SERVER_PORT_HOST)/docs or http://localhost:$(SERVER_PORT_HOST)/redoc"
	echo "or download the API spec directly from http://localhost:$(SERVER_PORT_HOST)/openapi.json"
	echo $(JUPYTER_TEXT)
	$(JUPYTER_RUN)
	export IMAGE_NAME_DB_ACTUAL=$(IMAGE_NAME_DB_ACTUAL); \
		docker compose -p $(APP_NAME) --env-file ./.env up -d --always-recreate-deps db
	while [ $$(docker inspect --format "{{json .State.Health.Status }}" $(CONTAINER_NAME_DB)) != "\"healthy\"" ]; do echo "Waiting for db..."; sleep 1; done
		export IMAGE_NAME_ACTUAL=$(IMAGE_NAME_ACTUAL); \
		docker compose -p $(APP_NAME) --env-file ./.env run --name $(APP_NAME) --service-ports --entrypoint="" web bash -c \
		"cd ./src; \
		uvicorn $(PACKAGE_NAME).main:app $(RELOAD) --host 0.0.0.0 --port $(SERVER_PORT_CONTAINER);"

ingest:
	$(info Running ingestion script to populate database...)
	export JUPYTER_PORT=$(JUPYTER_PORT); export CONTAINER_USER=$(CONTAINER_USER); export UID=$(UID); export GID=$(GID); docker compose -p $(APP_NAME) --env-file ./.env run jupyter bash -c "pip install httpx pandas; cd /home/$(CONTAINER_USER); jupyter nbconvert --to script PopulateDatabase.ipynb; cat PopulateDatabase.py | grep -v get_ipython > run.py; python run.py; rm PopulateDatabase.py run.py"

lint:
	$(info Linting source code...)
	docker compose -p $(APP_NAME)_lint down
	export IMAGE_NAME_ACTUAL=$(IMAGE_NAME_ACTUAL); \
	docker compose -p $(APP_NAME)_lint --env-file ./.env run --name $(APP_NAME)_lint --service-ports --entrypoint="" web bash -c \
	"pip install black; black /home/$(APP_DIR)/src/impl"

stop: clear
	$(info Shutting down...)
