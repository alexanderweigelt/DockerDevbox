# I!net marketing
#
# @project    Docker devbox
# @package    scripts
# @author     Alexander Weigelt <alexander.weigelt@netresearch.de>

include .env

# Documentation
default:
	@echo "\n\
    :: Tasks - Devbox\n\
    make run                                  Builds and ups all docker containers.\n\
    make down                                 Downs all docker containers.\n\
    make clean                                Docker cleanup container, images and volumes.\n\
    make bash                                 Starts an interactive bash session.\n\
    make mysql                                Starts an interactive mysql session.\n\
    make test                                 Tested started localhost.\n\
    make build                                Builds a Docker Image defined in Dockerfile.\n\
    make push                                 You can always push a new image to your repository.\n\
    \n\
	"

build:
	docker build -t ${REPOSITORY}:latest .

push:
	docker push ${REPOSITORY}:latest

run:
	docker-compose up -d
# synonym to run
up: run

down:
	docker-compose down

bash:
	docker exec -ti ${CONTAINER_NAME_WEB} bash

mysql:
	docker exec -ti ${CONTAINER_NAME_DB} bash

test:
	curl localhost

clean:
	sh docker_cleanup.sh

.PHONY: build run up bash mysql test clean down
