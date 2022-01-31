# Devbox

Devbox based on Apache PHP 8.1 using docker. Use it only as a develop environment!

## Dependencies

-   Install docker: https://docs.docker.com/engine/installation/


## Getting Started

### First time

1. `cp .env.dist .env` and adapt application settings in .env file
2. `make build` to build docker images
3. `make up` to start the application

### Daily work

Use the make command to control the Application

-   Get help (list all commands):

        make
        
        # :: Tasks - Devbox
        # make up                                  Builds and ups all docker containers.
        # make down                                 Downs all docker containers.
        
        # :: Tasks Deployment
        # make build                                Builds a Docker Image defined in Dockerfile.
        
        # :: Tasks Development
        # make bash                                 Starts an interactive bash session.
        # make mysql                                Starts an interactive mysql session.
        # make run <command> [OPTION]               Run bash command inside docker container.
                                                    Available commands:
                                                         - make run add-vhost yourdomain.com
                                                         - make run xdebug <your_ip>
-   Build docker image:

        make build
        
        # docker-compose build

-   Run app:

        make run
        
        # docker-compose up -d

-   Stop app:

        make down
        
        # docker-compose down
    
-   Get mapped port (last column) using:

        docker ps -a

        > # Example
        > ID                  IMAGE                     COMMAND                  CREATED             STATUS              PORTS
        > 2703c7504513        alexanderweigelt/devbox   "docker-php-entryp..."   8 hours ago         Up 8 hours          80/tcp, 0.0.0.0:8080->8080/tcp   devbox
    
### Webroot

-   Add sources to `app` folder.

-   Open your browser and call address [http://localhost](http://localhost)

### Database

- Get database credentials from .env file

- *Note: The database host is* `db`

### ssh/sftp

* User: app
* Password: app
* Port: 2220 (get the port mapping from .env file)
* Host: localhost

`ssh -p2220 app@localhost`

### Installed Tools

1. Composer
2. Xdebug
3. Node.js
4. PHP CodeSniffer
5. PHP-CS-Fixer

### Mutagen.io support (optional)

Before we can start the application itself with mutagen.io, we have to install some tools.

1. Homebrew: https://brew.sh/index_de CMD Tool for installations
2. Docker for Mac: https://hub.docker.com/editions/community/docker-ce-desktop-mac/
3. Mutagen.io https://mutagen.io/documentation/introduction/installation

#### Install mutagen.io on MacOS

Subscribe to the edge release channel (NOT RECOMMENDED!)

If you want to use compose mutagen you have to install version 0.12.0-beta2

(Status from 2020-11-01)

`brew install mutagen-io/mutagen/mutagen-edge`

## Known issues

1. `mutagen-compose` is untested
2. Run phpcs with make command does not work

## Links

-   [docker](https://cloud.docker.com/swarm/alexanderweigelt/repository/docker/alexanderweigelt/devbox/general)

-   [GitHub](https://github.com/alexanderweigelt/Docker-devbox)
