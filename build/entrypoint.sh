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

    echo "Cron is enabled. Preparing crontab..."

    mkdir -p /root/.cache

    # Create a temporary crontab with env vars at the top
    {
        echo "S3_REMOTE=\"$S3_REMOTE\""
        echo "S3_PATH=\"$S3_PATH\""
        echo "ENABLE_CRON=\"$ENABLE_CRON\""
        cat /crontab
    } > /tmp/crontab

    # Install the new crontab
    crontab /tmp/crontab

    # Ensure log file exists
    touch /var/log/cron.log
    chmod 666 /var/log/cron.log

    # Start crond in foreground with syslog format (-s)
    exec crond -f -s
else
    echo "Cron is disabled. Running download.sh directly..."
    /download.sh
fi
