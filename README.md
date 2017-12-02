# Devbox

Devbox based on Apache PHP 7.1 using docker.

## Prerequisites

-   Install docker:

        https://docs.docker.com/engine/installation/

-   Install `curl`:

        sudo apt-get install curl

### Settings

-   Open .env file in editor

-   Change and save settings

## Getting Started

Use the make command to control the Application

-   Get help (list all commands):

        make
        
        # :: Tasks - Devbox
        # make run                                  Builds and ups all docker containers.
        # make down                                 Downs all docker containers.
        # make clean                                Docker cleanup container, images and volumes.
        # make bash                                 Starts an interactive bash session.
        # make mysql                                Starts an interactive mysql session.
        # make test                                 Tested started localhost.
        # make build                                Builds a Docker Image defined in Dockerfile.
        # make push                                 You can always push a new image to your repository.

-   Build docker image:

        make build
        
        # docker build -t alexanderweigelt/devbox .

-   Run app:

        make run
        
        # docker-compose up -d

-   Test app using the port in previous step:

        make test
        
        # curl localhost

-   Get mapped port (last column) using:

        docker ps

        > # Example
        > ID                  IMAGE                     COMMAND                  CREATED             STATUS              PORTS
        > 2703c7504513        alexanderweigelt/devbox   "docker-php-entryp..."   8 hours ago         Up 8 hours          80/tcp, 0.0.0.0:8080->8080/tcp   devbox

    It should print `Hello World` to the console.
    
### Webroot

-   Add sources to `htdocs` folder.

-   Open your browser and call address [http://localhost](http://localhost)

### Database

-   *Note: The database host is* `db`

### Installed Tools

1.  Composer

2.  Xdebug

3.  Node.js

4.  Grunt CLI

## Links

-   [docker](https://cloud.docker.com/swarm/alexanderweigelt/repository/docker/alexanderweigelt/devbox/general)

-   [GitHub](https://github.com/alexanderweigelt/Docker-devbox)
