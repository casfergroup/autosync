# Autosync

Autosync is a docker image that sync data periodically between local and remote host using Rclone.

## How to run
### Command-line
Run

```
docker run --rm \
  -e ENABLE_CRON=true \
  -e S3_REMOTE=myremote \
  -e S3_PATH=mybucket/backups \
  -v $(pwd)/rclone.conf:/root/.config/rclone/rclone.conf:ro \
  -v $(pwd)/local_data/:/data/ \
  casfergroup/autodumper:latest
```

### Docker compose

See examples on [examples/](examples).

## Environment Variables
Variable | Default | Required | Accepted Values | Description
---|---|---|---|---
CRON_ENABLE | false | | `true`, `false` | Enables cron syncs
CRON_TIME | */5 * * * * | | cron values | Sets a frequency for the job to run
S3_REMOTE | *none* | X | string | Name of the remote on rclone.conf to be used
S3_PATH | *none* | X | string | Path to sync on remote storage
JOB | 1 | | 1, 2 | Type of job (see following section)

### JOB
Implement the functionality to synchronize data from remote to local, or from local to remote.

Value   |    Description
1 | Sync remote → local
2 | Sync local → remote

