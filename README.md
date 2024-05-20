# Plausible Analytics Backup and Restore Scripts

This repository contains scripts to backup and restore your PostgreSQL database for a self-hosted Plausible Analytics setup - Community Edition. The backup script uses `pg_dumpall` to create a consistent database backup and compresses the backup file using `gzip`. The restore script decompresses the backup file and restores it using `psql`.

## Scripts

- `plausible_backup.sh`: This script backs up the PostgreSQL database and compresses the backup file.
- `plausible_restore.sh`: This script restores the PostgreSQL database from a compressed backup file.

## Configuration

Edit the following variables in both scripts as needed:

- `CONTAINER_NAME`: The name of your PostgreSQL container.
- `BACKUP_DIR`: The directory where the backup files will be stored.

### Prerequisites

- Docker and Docker Compose must be installed on your host machine.
- Ensure the PostgreSQL container is running.

### Finding Your Container Name

You need to know the name of your PostgreSQL container. You can find this using the `docker ps` command.

```sh
docker ps
```

This will list all running containers. Look for your PostgreSQL container in the **NAMES** column. The container name is usually something like **plausible_db**.

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

This will create a compressed backup file in the specified backup directory.

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

This will decompress the backup file and restore the database in your PostgreSQL container.

## License

These scripts are free to use and share. Feel free to modify and distribute them as needed.

## Disclaimer

These scripts are provided as-is and without warranty. Use them at your own risk. Always backup your data before running any scripts.

## Contributions

Contributions are welcome. Feel free to submit a pull request or open an issue if you have any suggestions or improvements.