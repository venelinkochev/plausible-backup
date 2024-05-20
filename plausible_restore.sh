#!/bin/bash

# Set variables
CONTAINER_NAME="plausible_db"
GZIP_FILE="/path/to/backup/backup.sql.gz"
BACKUP_FILE="${GZIP_FILE%.gz}"

# Decompress the gzipped SQL file
gunzip -k $GZIP_FILE

# Copy the decompressed SQL file into the container
docker cp $BACKUP_FILE $CONTAINER_NAME:/backup.sql

# Restore the backup using psql
docker exec -i $CONTAINER_NAME psql -U postgres -f /backup.sql

# Optionally, remove the SQL file after restore
rm $BACKUP_FILE

echo "Restore completed from: $GZIP_FILE"
