#!/bin/sh
set -e  # Exit immediately if any command fails

# == Import functions ==
source /scripts/startup_functions.sh
source /scripts/worker.sh

# == Function
invoke() {
    if main; then
        echo "Job succeeded at $(date)"
    else
        echo "Job failed after 3 retries. Exiting..."
        exit 1
    fi
}

# == Main code ==
validate_envs

if [ "$CRON_ENABLE" = "true" ]; then
    # Do a first run
    invoke

    echo "Cron is enabled. Preparing crontab..."

    mkdir -p /root/.cache

    build_crontab > /tmp/crontab

    # Install the new crontab
    crontab /tmp/crontab

    # Start crond in foreground with syslog format (-s)
    exec crond -f -s
else
    echo "Cron is disabled. Running directly..."
    invoke
fi
