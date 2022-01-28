#!/bin/bash

if [ "$APP_ENV" == "production" ]; then
    echo 'Exit toolbox in production mode'
    exit 0
fi

# Configure Xdebug
if [ "$XDEBUG_ENABLE" == "true" ]; then
    docker-php-ext-enable xdebug
    echo 'Xdebug enabled'
fi

chown -R www-data:www-data "${HTTP_PROJECT_ROOT}"

service ssh start

# Keep alive .docker container
tail -f /dev/null
