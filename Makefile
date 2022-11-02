# I!net marketing
#
# @project    Docker devbox
# @package    scripts
# @author     Alexander Weigelt <webdesign@alexander-weigelt.de>

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
    \n\
    :: Deployment\n\
    make build                                Builds a Docker Image defined in Dockerfile.\n\
    make push                                 You can always push a new image to your repository.\n\
    \n\
    :: Development\n\
    make bash                                 Starts an interactive bash session.\n\
    make mysql                                Starts an interactive mysql session.\n\
    make phpcs                                Runs PHP_CodeSniffer to detect and fix violations of a defined set of coding standards.\n\
    make run <command> [OPTION]               Run bash command inside docker container.\n\
                                              Available commands:\n\
                                                 - make run fix-permission\n\
    :: Helper\n\
    make myip                                 Returns the primary IP address of the local machine.\n\
    "

# Note: Build the main production environment first.
# Runs the build of the toolbox last because it requires a php image with the current tag.
build: .env
	@docker-compose build php db httpd --no-cache --pull
	@docker-compose build toolbox --no-cache

up: .env
	@docker-compose up -d
	@echo -e "\033[1;92m Docker containers ... UP AND RUNNING\033[0m\n"

run: .env
	@docker-compose exec toolbox bash -c '$(RUN_ARGS)'

down: .env
	@docker-compose down
	@echo -e "\033[1;92m Docker containers ... DOWN\033[0m\n"

bash: .env
	@echo "\033[1;31m Note: use ssh to connect to the toolbox.\033[0m\n"
	@docker-compose exec toolbox bash

mysql: .env
	@docker-compose exec db bash

phpcs: .env
	@echo "\033[1;92m Test all php files in the folder: ${HTTP_DOCUMENT_ROOT}\033[0m\n"
	@docker-compose exec toolbox bash -c 'phpcs --standard=PSR12 $(RUN_ARGS) --basepath=${HTTP_DOCUMENT_ROOT} ${HTTP_DOCUMENT_ROOT}'

phpcbf: .env
	@echo "\033[1;92m Test all php files in the folder: ${HTTP_DOCUMENT_ROOT}\033[0m\n"
	@docker-compose exec toolbox bash -c 'phpcbf --standard=PSR12 $(RUN_ARGS) --basepath=${HTTP_DOCUMENT_ROOT} ${HTTP_DOCUMENT_ROOT}'

myip:
	@echo $(IP)

.PHONY: build up run down bash mysql myip phpcbf phpcs
