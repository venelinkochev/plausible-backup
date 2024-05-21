# Plausible Analytics Backup and Restore Scripts

This repository contains scripts to backup and restore your PostgreSQL and ClickHouse databases for a self-hosted Plausible Analytics setup - Community Edition. The backup script uses `pg_dumpall` to create a consistent PostgreSQL database backup and `clickhouse-client` to export ClickHouse tables to SQL files. Both backup files are compressed using `gzip` and `tar`. The restore script decompresses the backup files and restores them using `psql` and `clickhouse-client`.

## Scripts

- `plausible_backup.sh`: This script backs up the PostgreSQL database and compresses the backup file.
- `plausible_restore.sh`: This script restores the PostgreSQL database from a compressed backup file.

## Configuration

Edit the following variables in both scripts as needed:

- `PG_CONTAINER_NAME`: The name of your PostgreSQL container.
- `CH_CONTAINER_NAME`: The name of your ClickHouse container.
- `BACKUP_DIR`: The directory where the backup files will be stored.
- `PG_GZIP_FILE`: The path to the compressed PostgreSQL backup file.
- `CH_TAR_FILE`: The path to the compressed ClickHouse backup file.

### Prerequisites

- Docker and Docker Compose must be installed on your host machine.
- Ensure the PostgreSQL and ClickHouse containers are running.

### Finding Your Container Name

You need to know the names of your PostgreSQL and ClickHouse containers. You can find these using the `docker ps` command.
```sh
docker ps
```

This will list all running containers. Look for your PostgreSQL container in the **NAMES** column. The container name is usually something like **plausible_db** and **plausible_events_db**.

## Usage

### Backup

1. Save the `plausible_backup.sh` script to your machine.
2. Make the script executable.

```sh
chmod +x plausible_backup.sh
```

3. Run the script.

```sh
./plausible_backup.sh
```

This will create a compressed backup files in the specified backup directory.

### Restore

1. Save the `plausible_restore.sh` script to your machine.
2. Make the script executable.

```sh
chmod +x plausible_restore.sh
```

3. Run the script.

```sh
./plausible_restore.sh
```

This will decompress the backup files and restore the databases in your PostgreSQL and ClickHouse containers.
## License

These scripts are free to use and share. Feel free to modify and distribute them as needed.

## Disclaimer

These scripts are provided as-is and without warranty. Use them at your own risk. Always backup your data before running any scripts.

## Contributions

Contributions are welcome. Feel free to submit a pull request or open an issue if you have any suggestions or improvements.