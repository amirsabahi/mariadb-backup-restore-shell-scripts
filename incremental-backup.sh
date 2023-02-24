#!/bin/bash

# Set the encrypted credentials file and backup directory
encrypted_file="/path/to/encrypted/credentials/file"
backup_dir="/path/to/backup/dir"
backup_name="$(date +%Y-%m-%d_%H-%M-%S)"

# Decrypt the credentials file and read the username and password
if [ -f "$encrypted_file" ]; then
    read -r username < <(gpg --quiet --decrypt "$encrypted_file" | head -n 1)
    read -r password < <(gpg --quiet --decrypt "$encrypted_file" | tail -n 1)
else
    echo "Error: encrypted credentials file not found"
    exit 1
fi

# Create the incremental backup
sudo mariabackup --backup \
    --user="$username" \
    --password="$password" \
    --target-dir="$backup_dir/$backup_name" \
    --incremental-basedir="$backup_dir/latest"

# Update the latest backup symlink
rm -f "$backup_dir/latest"
ln -s "$backup_dir/$backup
