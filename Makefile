# I!net marketing
#
# @project    Docker devbox
# @package    scripts
# @author     Alexander Weigelt <alexander.weigelt@netresearch.de>

# Documentation
default:
	@echo "\n\
    :: Tasks - Development\n\
    make run                                  Builds and ups all docker containers.\n\
    make down                                 Downs all docker containers.\n\
    make update                               Updates composer packages.\n\
    make bash                                 Starts an interactive bash session.\n\
    make pull                                 Pulls images associated with a service defined in a docker-compose.yml.\n\
    make build                                Builds a Docker Image defined in Dockerfile\n\
    \n\
	"

build:
	docker build -t alexanderweigelt/devbox:latest .

run:
	docker-compose up -d

down:
	docker-compose down

bash:
	docker exec -ti devbox bash

test:
	curl localhost

clean: down
	docker rm devbox

.PHONY: build run test clean
