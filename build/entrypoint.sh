#!/bin/sh

if [ "$ENABLE_CRON" = "true" ]; then
    echo "Cron is enabled. Installing crontab and starting crond..."
    crontab /crontab
    crond -f -L /var/log/cron.log
else
    echo "Cron is disabled. Running entrypoint.sh directly..."
    /entrypoint.sh
fi