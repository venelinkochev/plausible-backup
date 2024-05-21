#!/bin/bash

# Set variables
PG_CONTAINER_NAME="plausible_db"
CH_CONTAINER_NAME="plausible_events_db"
PG_GZIP_FILE="/path/to/backup/postgresql-backup.sql.gz"
PG_BACKUP_FILE="${PG_GZIP_FILE%.gz}"
CH_TAR_FILE="/path/to/backup/clickhouse-backup.tar.gz"
CH_BACKUP_DIR="/path/to/backup/clickhouse-backup-dir"

# Decompress the PostgreSQL gzipped SQL file
gunzip -k $PG_GZIP_FILE

# Copy the decompressed PostgreSQL SQL file into the container
docker cp $PG_BACKUP_FILE $PG_CONTAINER_NAME:/backup.sql

# Restore the PostgreSQL backup using psql
docker exec -i $PG_CONTAINER_NAME psql -U postgres -f /backup.sql

# Optionally, remove the PostgreSQL SQL file after restore
rm $PG_BACKUP_FILE

# Extract the ClickHouse backup tarball on the host
tar -xzvf $CH_TAR_FILE -C $BACKUP_DIR

# Restore each ClickHouse table
tables=$(docker exec -t $CH_CONTAINER_NAME clickhouse-client --query="SHOW TABLES FROM plausible_events_db")

for table in $tables; do
  table_name=$(echo $table | tr -d '\r')
  docker exec -i $CH_CONTAINER_NAME clickhouse-client --query="INSERT INTO plausible_events_db.$table_name FORMAT SQLInsert" < $CH_BACKUP_DIR/$table_name.sql
done

# Optionally, remove the extracted backup directory from the host
rm -rf $CH_BACKUP_DIR

echo "Restore completed from: $PG_GZIP_FILE and $CH_TAR_FILE"
