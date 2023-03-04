#!/bin/bash

# Prompt user for database credentials
read -p "Enter PostgreSQL username: " username
read -sp "Enter PostgreSQL password: " password
echo ""
read -p "Enter PostgreSQL database name: " dbname

# Prompt user for backup directory location
read -p "Enter backup directory location: " backup_dir

# Define color codes
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

function create_backup() {
    # Create backup directory if it doesn't exist
    if [ ! -d $backup_dir ]; then
        mkdir -p $backup_dir
    fi

    # Create timestamp for backup file name
    timestamp=$(date +%Y-%m-%d_%H-%M-%S)

    # Perform physical backup using pg_basebackup
    echo -e "${YELLOW}Creating physical backup...${NC}"
    pg_basebackup -U $username -D $backup_dir/$timestamp -F t -z -P -x -R -c fast -l "Physical backup created on $timestamp" -v

    # Check if backup was successful
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Physical backup created successfully.${NC}"
    else
        echo -e "${RED}Failed to create physical backup.${NC}"
        exit 1
    fi
}

function restore_backup() {
    # Prompt user for backup file location
    read -p "Enter backup file location: " backup_file

    # Check if backup file exists
    if [ ! -f $backup_file ]; then
        echo -e "${RED}Backup file does not exist.${NC}"
        exit 1
    fi

    # Stop PostgreSQL service
    echo -e "${YELLOW}Stopping PostgreSQL service...${NC}"
    systemctl stop postgresql

    # Restore backup using pg_restore
    echo -e "${YELLOW}Restoring backup...${NC}"
    pg_restore -U $username -d $dbname $backup_file

    # Check if restore was successful
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Backup restored successfully.${NC}"
    else
        echo -e "${RED}Failed to restore backup.${NC}"
        exit 1
    fi

    # Start PostgreSQL service
    echo -e "${YELLOW}Starting PostgreSQL service...${NC}"
    systemctl start postgresql
}

# Prompt user for backup or restore operation
echo -e "${YELLOW}Select operation: 1) Backup 2) Restore${NC}"
read -p "Enter operation number: " operation

# Perform backup or restore operation based on user input
if [ $operation -eq 1 ]; then
    create_backup
elif [ $operation -eq 2 ]; then
    restore_backup
else
    echo -e "${RED}Invalid operation number.${NC}"
    exit 1
fi
