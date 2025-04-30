#!/bin/sh
set -e  # Exit immediately if any command fails

# == ENV Validation ==
required_vars="S3_REMOTE S3_PATH"
for var in $required_vars; do
    eval "value=\${$var}"
    if [ -z "$value" ]; then
        echo "Error: Required variable $var is not set!"
        exit 1
    fi
done

if [ "$ENABLE_CRON" = "true" ]; then
    echo "1st run"
    /download.sh

    echo "Cron is enabled. Installing crontab and starting crond..."
    mkdir -p /root/.cache
    crontab /crontab

    # Ensure log file exists
    touch /var/log/cron.log
    chmod 666 /var/log/cron.log

    # Start crond in foreground
    exec crond -f -s
else
    echo "Cron is disabled. Running entrypoint.sh directly..."
    /download.sh
fi
