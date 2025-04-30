#!/bin/sh
set -e  # Exit immediately if any command fails

if [ "$ENABLE_CRON" = "true" ]; then
    echo "1st run"
    /download.sh
    echo "Cron is enabled. Installing crontab and starting crond..."
    crontab /crontab
    cron -f | tail -f /tmp/stdout
else
    echo "Cron is disabled. Running entrypoint.sh directly..."
    /download.sh
fi
