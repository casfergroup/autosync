#!/bin/sh

# === File Permissions ==
#umask 077

# === Function to download with rclone ===
download_with_retries() {
    attempt=1
    max_attempts=3

    while [ "$attempt" -le "$max_attempts" ]; do
        echo "Attempt $attempt to download from $S3_REMOTE:$S3_PATH to /data via rclone..."
        if rclone sync "$S3_REMOTE:$S3_PATH" /data/ 2>&1; then
            echo "Download successful."
            return 0
        else
            echo "Download failed on attempt $attempt."
            attempt=$((attempt + 1))
            sleep 5
        fi
    done

    return 1
}

# === Main logic ===
if download_with_retries; then
    echo "Download succeeded at $(date)"
else
    echo "Download failed after 3 retries. No files downloaded."
    exit 1
fi
