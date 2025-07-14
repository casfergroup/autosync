# Basic setup

This template creates a basic setup of autosync, syncing files from S3 to a local `/media/your_data/` directory on the server.

## Usage
1. Place your rclone.conf configuration file in the root of your project directory (you can generate one using `rclone config`).
2. Adjust the local directory (`/media/your_data/`) to the folder containing the data you wish to sync.
3. Update the S3 remote name and path in the environment variables as needed.
4. Run the following command to start the service:
```
docker compose up -d
```

This will start the autosync service in the background.

### Cron Job

The service will run the sync job every minute, based on the cron schedule (`*/1 * * * *`). You can use [https://crontab.guru/](https://crontab.guru/) to generate a new one according to your requirements.
