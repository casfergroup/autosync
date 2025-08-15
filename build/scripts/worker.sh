#!/bin/sh

# == File Permissions ==
#umask 077

# == Function to copy from remote to local ==
remote_to_local() {
    local action="$1"
    local attempt=1
    local max_attempts="${2:-3}"

    while [ "$attempt" -le "$max_attempts" ]; do
        echo "Attempt $attempt to $action from $S3_REMOTE:$S3_PATH to /data via rclone..."
        if rclone $action "$S3_REMOTE:$S3_PATH" /data/ 2>&1; then
            echo "$action successful."
            return 0
        else
            echo "$action failed on attempt $attempt."
            attempt=$((attempt + 1))
            sleep 5
        fi
    done

    return 1
}

# == Main logic ==
main() {
    TASK=1 # Future feature
    
    case $TASK in
    1)
        remote_to_local sync
        ;;
    *)
        echo "An unexpected error occured!"
        exit 1
        ;;
    esac
}