#!/bin/bash

# Ask user for database name, backup file path, and mariabackup path
read -p "Enter database name: " dbname
read -p "Enter backup file path: " backupfile
read -p "Enter mariabackup path: " mariabackuppath

# Check if backup file exists
if [ ! -f "$backupfile" ]; then
  echo "Backup file does not exist."
  exit 1
fi

# Check if MariaDB is running
if ! pgrep mysqld &> /dev/null ; then
  echo "MariaDB is not running."
  exit 1
fi

# Stop MariaDB service
systemctl stop mariadb

# Remove the existing database directory
rm -rf /var/lib/mysql/$dbname

# Restore the database
$MARIABACKUP --prepare --target-dir=$backupfile
$MARIABACKUP --copy-back --target-dir=$backupfile

# Fix permissions and ownership
chown -R mysql:mysql /var/lib/mysql/$dbname
chmod -R 755 /var/lib/mysql/$dbname

# Start MariaDB service
systemctl start mariadb

# Check if MariaDB is running
if ! pgrep mysqld &> /dev/null ; then
  echo "MariaDB did not start successfully after restore."
  exit 1
fi
