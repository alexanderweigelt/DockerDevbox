#!/bin/bash

# Configure Sendmail if required
if [ "$SENDMAIL_ENABLE" == "true" ]; then
    /etc/init.d/sendmail start
    echo 'Sendmail started'
fi

# Configure Xdebug
if [ "$XDEBUG_ENABLE" == "true" ]; then
    docker-php-ext-enable xdebug
    echo 'Xdebug enabled'
fi

exec "$@"
