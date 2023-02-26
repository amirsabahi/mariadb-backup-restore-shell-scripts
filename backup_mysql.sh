#!/bin/bash

# Get database credentials
echo "Enter database username:"
read -r DB_USER

echo "Enter database password:"
read -r DB_PASS

echo "Enter database name:"
read -r DB_NAME

# Set backup file name and location
echo "Enter backup file name (without extension):"
read -r BACKUP_NAME

echo "Enter backup destination directory:"
read -r BACKUP_DIR

BACKUP_FILE="$BACKUP_DIR/$BACKUP_NAME-$(date +%Y%m%d%H%M%S).sql"

# Create backup
echo "Creating backup..."
if [ "$1" == "-c" ]; then
    # Compress backup file
    mysqldump -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" | gzip > "$BACKUP_FILE".gz
else
    # Non-compressed backup file
    mysqldump -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" > "$BACKUP_FILE"
fi

echo "Backup created: $BACKUP_FILE"
