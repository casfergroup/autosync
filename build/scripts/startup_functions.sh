#!/bin/sh

# == Builds the Crontab ==
build_crontab() {
    local CRON_EXPRESSION="/scripts/crontab.sh >> /var/log/cron.log 2>&1" # Future feature

    echo "# Crontab generated on $(date)"
    echo "S3_REMOTE=\"$S3_REMOTE\""
    echo "S3_PATH=\"$S3_PATH\""
    echo "$CRON_TIME $CRON_EXPRESSION"
}

## == Validates user defined ENVs ==
validate_envs() {
    local required_vars="S3_REMOTE S3_PATH"
    for var in $required_vars; do
        eval "value=\${$var}"
        if [ -z "$value" ]; then
            echo "Error: Required variable $var is not set!"
            exit 1
        fi
    done
}