#!/bin/bash

# Set variables
CONTAINER_NAME="plausible_db"
BACKUP_DIR="/path/to/backup"
TIMESTAMP=$(date +"%Y%m%d%H%M")
BACKUP_FILE="$BACKUP_DIR/plausible-backup-$TIMESTAMP.sql"

# Create backup directory if it doesn't exist
mkdir -p $BACKUP_DIR

# Run pg_dumpall inside the container and output to the host
docker exec -t $CONTAINER_NAME pg_dumpall -c -U postgres > $BACKUP_FILE

# Compress the SQL backup file
gzip $BACKUP_FILE

echo "Backup completed: $BACKUP_FILE"
