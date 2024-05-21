#!/bin/bash

# Set variables
BACKUP_DIR="/path/to/backup"
TIMESTAMP=$(date +"%F")
PG_CONTAINER_NAME="plausible_db"
CH_CONTAINER_NAME="plausible_events_db"
PG_BACKUP_FILE="$BACKUP_DIR/postgresql-backup-$TIMESTAMP.sql"
PG_GZIP_FILE="$PG_BACKUP_FILE.gz"
CH_BACKUP_DIR="$BACKUP_DIR/clickhouse-backup-$TIMESTAMP"
CH_TAR_FILE="$CH_BACKUP_DIR.tar.gz"

# Create backup directory if it doesn't exist
mkdir -p $BACKUP_DIR
mkdir -p $CH_BACKUP_DIR

# Run pg_dumpall inside the PostgreSQL container and output to the host
docker exec -t $PG_CONTAINER_NAME pg_dumpall -c -U postgres > $PG_BACKUP_FILE

# Compress the PostgreSQL SQL backup file
gzip $PG_BACKUP_FILE

# Get a list of ClickHouse tables
tables=$(docker exec -t $CH_CONTAINER_NAME clickhouse-client --query="SHOW TABLES FROM plausible_events_db")

# Export each table to an SQL file
for table in $tables; do
  table_name=$(echo $table | tr -d '\r')
  docker exec -t $CH_CONTAINER_NAME clickhouse-client --query="SELECT * FROM plausible_events_db.$table_name FORMAT SQLInsert" > $CH_BACKUP_DIR/$table_name.sql
done

# Compress the ClickHouse backup directory
tar -czvf $CH_TAR_FILE -C $BACKUP_DIR $(basename $CH_BACKUP_DIR)

echo "Backup completed: $PG_GZIP_FILE and $CH_TAR_FILE"
