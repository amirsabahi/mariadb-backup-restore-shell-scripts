#!/bin/bash

# Prompt user for input
echo "Please choose an action to perform:"
echo "1. Backup PostgreSQL database"
echo "2. Restore PostgreSQL database"
read -p "Enter your choice [1-2]: " choice

# Define color codes
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to backup PostgreSQL database
function backup_db {
    # Prompt user for database credentials
    read -p "Enter PostgreSQL username: " username
    read -sp "Enter PostgreSQL password: " password
    echo ""
    read -p "Enter PostgreSQL database name: " dbname
    
    # Prompt user for backup file location
    read -p "Enter backup file location (local or remote): " location
    
    if [ $location == "remote" ]; then
        read -p "Enter remote server IP address or hostname: " remote_host
        read -p "Enter remote directory path: " remote_path
        
        echo -e "${YELLOW}Creating backup file on remote server...${NC}"
        ssh $remote_host "PGPASSWORD=$password pg_dump -U $username $dbname > $remote_path/$dbname.sql"
        
        echo -e "${GREEN}Backup file created on remote server.${NC}"
    else
        read -p "Enter backup file name: " filename
        
        echo -e "${YELLOW}Creating backup file locally...${NC}"
        PGPASSWORD=$password pg_dump -U $username $dbname > $filename.sql
        
        echo -e "${GREEN}Backup file created locally.${NC}"
    fi
}

# Function to restore PostgreSQL database
function restore_db {
    # Prompt user for database credentials
    read -p "Enter PostgreSQL username: " username
    read -sp "Enter PostgreSQL password: " password
    echo ""
    read -p "Enter PostgreSQL database name: " dbname
    
    # Prompt user for backup file location
    read -p "Enter backup file location (local or remote): " location
    
    if [ $location == "remote" ]; then
        read -p "Enter remote server IP address or hostname: " remote_host
        read -p "Enter remote directory path: " remote_path
        read -p "Enter backup file name: " filename
        
        echo -e "${YELLOW}Restoring backup file from remote server...${NC}"
        ssh $remote_host "PGPASSWORD=$password psql -U $username -d $dbname -f $remote_path/$filename.sql"
        
        echo -e "${GREEN}Backup file restored from remote server.${NC}"
    else
        read -p "Enter backup file name: " filename
        
        echo -e "${YELLOW}Restoring backup file locally...${NC}"
        PGPASSWORD=$password psql -U $username -d $dbname -f $filename.sql
        
        echo -e "${GREEN}Backup file restored locally.${NC}"
    fi
}

# Perform the chosen action
case $choice in
    1)
        backup_db
        ;;
    2)
        restore_db
        ;;
    *)
        echo "Invalid choice."
        exit 1
        ;;
esac
