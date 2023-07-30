#!/bin/bash

# Get command-line arguments
DB_USER="$1"
DB_PASSWORD="$2"
DB_NAME="$3"
BACKUP_LOCATION="$4"
TRANSFER_LOCATION="$5"

# Function to display script usage
function display_usage() {
    echo "Usage: $0 <db_user> <db_password> <db_name> <backup_location> [-t <transfer_location>]"
}

# Check if any required argument is missing
if [[ -z $DB_USER || -z $DB_PASSWORD || -z $DB_NAME || -z $BACKUP_LOCATION ]]; then
    display_usage
    exit 1
fi

# Check if the "-h" option is passed to display usage
if [[ "$DB_USER" == "-h" || "$DB_PASSWORD" == "-h" || "$DB_NAME" == "-h" || "$BACKUP_LOCATION" == "-h" ]]; then
    display_usage
    exit 0
fi

# Set the backup path and filename
BACKUP_DIR="/path/to/backup/directory"
BACKUP_FILE="$BACKUP_DIR/$(date +%Y-%m-%d_%H-%M-%S).tar.gz"

# Generate the backup and compress it
echo "Starting backup..."
mariabackup --user=$DB_USER --password=$DB_PASSWORD --databases $DB_NAME --target-dir=$BACKUP_DIR --backup --stream=xbstream | gzip | openssl  enc -aes-256-cbc -k STRONG_PASS > backup.xb.gz.enc
# tar czf $BACKUP_FILE $BACKUP_DIR/$(basename $BACKUP_DIR)
# rm -rf $BACKUP_DIR/$(basename $BACKUP_DIR)

# Check if the backup location exists, if not create it
if [ ! -d "$BACKUP_LOCATION" ]; then
    mkdir -p "$BACKUP_LOCATION"
fi

# Move the backup file to the specified location
mv $BACKUP_FILE $BACKUP_LOCATION

# Transfer the backup file to another location if specified
if [[ -n $TRANSFER_LOCATION ]]; then
    echo "Transferring backup file to $TRANSFER_LOCATION..."
    cp "$BACKUP_LOCATION/$(basename $BACKUP_FILE)" "$TRANSFER_LOCATION"
fi

# Show progress while compressing
echo "Compressing backup..."
pv "$BACKUP_LOCATION/$(basename $BACKUP_FILE)" > "$BACKUP_LOCATION/$(basename $BACKUP_FILE).gz"

echo "Backup completed"
