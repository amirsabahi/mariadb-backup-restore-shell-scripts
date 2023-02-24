#!/bin/bash

# Do not use in production.

# Prompt user for database credentials and name
read -p "Enter database username: " USER
read -s -p "Enter database password: " PASSWORD
echo
read -p "Enter database name: " DB_NAME

# Set the backup path and filename
BACKUP_DIR="/path/to/backup/directory"
BACKUP_FILE="$BACKUP_DIR/$(date +%Y-%m-%d_%H-%M-%S).tar.gz"

# Generate the backup and compress it
echo "Starting backup..."
mariabackup --user=$USER --password=$PASSWORD --databases $DB_NAME --target-dir=$BACKUP_DIR --backup
tar czf $BACKUP_FILE $BACKUP_DIR/$(basename $BACKUP_DIR)
rm -rf $BACKUP_DIR/$(basename $BACKUP_DIR)

# Show progress while compressing
echo "Compressing backup..."
pv $BACKUP_FILE > $BACKUP_FILE.gz

echo "Backup completed"
