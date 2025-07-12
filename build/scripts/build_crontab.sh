#!/bin/sh

build_crontab() {
    local CRON_EXPRESSION="/scripts/download.sh >> /var/log/cron.log 2>&1" # Future feature

    echo "# Crontab generated on $(date)"
    echo "$CRON_TIME $CRON_EXPRESSION"
}