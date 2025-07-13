#!/bin/sh
set -e  # Exit immediately if any command fails

# == Import functions ==
source /scripts/worker.sh

if main; then
    echo "Job succeeded at $(date)"
else
    echo "Job failed after 3 retries. Exiting..."
    exit 1
fi