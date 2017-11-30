# Devbox

Devbox on PHP 7.1 Apache using docker.

## Prerequisites

-   Rename .env.sample to .env

-   Save settings

## Getting Started

-   Install docker:

        https://docs.docker.com/engine/installation/

-   Build docker image:

        make build
        # docker build -t alexanderweigelt/devbox .

-   Run app:

        make run
        # docker-compose up -d

-   Install `curl`:

        sudo apt-get install curl

-   Get mapped port (last column) using, e.g. 49160:

        docker ps

        > # Example
        > ID                  IMAGE                     COMMAND                  CREATED             STATUS              PORTS
        > 2703c7504513        alexanderweigelt/devbox   "docker-php-entryp..."   8 hours ago         Up 8 hours          80/tcp, 0.0.0.0:8080->8080/tcp   devbox

-   Test app using the port in previous step, e.g. 49160:

        curl localhost:<port>

        # Example
        # curl localhost:8080

    It should print `Hello World` to the console.
    
## Webroot

-   Add sources to `htdocs` folder.

## Links

-   [docker](http://docker.io)

-   [GitHub](https://github.com/alexanderweigelt/Docker-devbox)
