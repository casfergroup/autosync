# Autosync

Autosync is a docker image that sync data periodically between hosts using Rclone.

## How to run
### Command-line
Run

```
docker run --rm \
  -e ENABLE_CRON=true \
  -e S3_REMOTE=myremote \
  -e S3_PATH=mybucket/backups \
  -v $(pwd)/rclone.conf:/root/.config/rclone/rclone.conf:ro \
  casfergroup/autodumper:latest
```

### Docker compose

See examples on examples/.