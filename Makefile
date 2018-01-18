# I!net marketing
#
# @project    Docker devbox
# @package    scripts
# @author     Alexander Weigelt <alexander.weigelt@netresearch.de>

include .env

# If the first argument is "run"...
ifeq (run,$(firstword $(MAKECMDGOALS)))
  # use the rest as arguments for "run"
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(RUN_ARGS):;@:)
endif

IP=$$(ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1')

# Documentation
default:
	@echo "\n\
    \n\
    :: Tasks - Devbox\n\
    make up                                   Builds and ups all docker containers.\n\
    make down                                 Downs all docker containers.\n\
    make clean                                Docker cleanup container, images and volumes.\n\
    \n\
    :: Deployment\n\
    make build                                Builds a Docker Image defined in Dockerfile.\n\
    make push                                 You can always push a new image to your repository.\n\
    \n\
    :: Development\n\
    make bash                                 Starts an interactive bash session.\n\
    make mysql                                Starts an interactive mysql session.\n\
    make run <command> [OPTION]               Run bash command inside docker container.\n\
                                              Available commands:\n\
                                                 - make run add-vhost yourdomain.com\n\
                                                 - make run xdebug $(IP)\n\
    :: Helper\n\
    make myip                                 Returns the primary IP address of the local machine.\n\
    make test                                 Tested started localhost.\n\
    "

build:
	docker build -t ${REPOSITORY}:${TAG} .

push:
	docker push ${REPOSITORY}:${TAG}

up:
	docker-compose up -d

run:
	docker-compose exec web bash -c '$(RUN_ARGS)'

down:
	docker-compose down -v

bash:
	docker-compose exec web bash

mysql:
	docker-compose exec db bash

test:
	curl localhost

clean:
	sh docker_cleanup.sh

myip:
	@echo $(IP)

.PHONY: build push up run down bash mysql test clean myip
