#!/bin/bash

if [ "$APP_ENV" == "prod" ]; then
    echo 'Exit toolbox in production mode'
    exit 0
fi

chown -R www-data:www-data "${HTTP_PROJECT_ROOT}"

service ssh start

# Keep alive .docker container
tail -f /dev/null
