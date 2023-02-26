#!/bin/bash

# Get SQL file location
echo "Enter SQL file location (remote or local):"
read -r SQL_FILE_LOCATION

if [[ "$SQL_FILE_LOCATION" == *"@"* ]]; then
    # SQL file is on a remote server
    echo "Enter SSH username for remote server:"
    read -r REMOTE_USER

    echo "Enter remote server IP address:"
    read -r REMOTE_IP

    echo "Enter remote file path:"
    read -r REMOTE_FILE_PATH

    # Download SQL file from remote server
    echo "Downloading SQL file..."
    scp "$REMOTE_USER"@"$REMOTE_IP":"$REMOTE_FILE_PATH" /tmp/sql_file.sql

    SQL_FILE="/tmp/sql_file.sql"
else
    # SQL file is on a local directory
    echo "Enter SQL file path:"
    read -r SQL_FILE

    if [ ! -f "$SQL_FILE" ]; then
        echo "Error: SQL file not found"
        exit 1
    fi
fi

# Get database credentials
echo "Enter database username:"
read -r DB_USER

echo "Enter database password:"
read -rs DB_PASS

echo "Enter database name:"
read -r DB_NAME

echo "Enter MySQL server IP address:"
read -r MYSQL_IP

# Import SQL file
echo "Importing SQL file..."
mysql -h "$MYSQL_IP" -u "$DB_USER" -p"$DB_PASS" "$DB_NAME" < "$SQL_FILE"

echo "SQL file imported successfully"
