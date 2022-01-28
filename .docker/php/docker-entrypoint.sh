#!/bin/bash

# Configure Sendmail if required
if [ "$SENDMAIL_ENABLE" == "true" ]; then
    /etc/init.d/sendmail start
    echo 'Sendmail started'
fi

exec "$@"
