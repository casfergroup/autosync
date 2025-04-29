FROM alpine:latest

ENV S3_REMOTE=""
ENV S3_PATH=""
ENV ENABLE_CRON="false"

# Install dependencies
RUN apk update && \
    apk upgrade --available && \
    apk add --no-cache \
        ca-certificates \
        rclone \
        cronie

WORKDIR /data

# Copy script and crontab
COPY download.sh /download.sh
COPY crontab /crontab
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /download.sh /entrypoint.sh

# Use a wrapper script to control cron behavior
CMD ["/entrypoint.sh"]
