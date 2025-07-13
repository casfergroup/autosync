FROM alpine:latest

ENV S3_REMOTE=""
ENV S3_PATH=""
ENV CRON_ENABLE="false"
ENV CRON_TIME="*/5 * * * *"

# Install dependencies
RUN apk update && \
    apk upgrade --available && \
    apk add --no-cache \
        ca-certificates \
        rclone \
        cronie

WORKDIR /data

# Copy script and crontab
COPY ./scripts/ /scripts/
COPY entrypoint.sh /entrypoint.sh

# Logs
RUN touch /var/log/cron.log \
    && chmod 666 /var/log/cron.log

RUN chmod -R +x /entrypoint.sh /scripts/

# Use a wrapper script to control cron behavior
CMD ["/entrypoint.sh"]
