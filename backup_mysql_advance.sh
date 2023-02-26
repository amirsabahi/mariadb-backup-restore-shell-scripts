#!/bin/bash

# Get MySQL username
read -p "Enter MySQL username: " username

# Get MySQL password
read -s -p "Enter MySQL password: " password
echo

# Get MySQL server IP address
read -p "Enter MySQL server IP address: " server

# Get list of databases
databases=$(mysql -u $username -p$password -h $server -e "SHOW DATABASES;" | grep -Ev "(Database|information_schema|performance_schema)")

# Prompt user to select a database to backup or backup all databases
echo "Select a database to backup or backup all databases:"
echo "1. Backup all databases"
select db in ${databases[@]} "Quit"
do
    case $db in
        "Quit")
            break
            ;;
        *)
            # Set filename
            if [ "$db" == "information_schema" ] || [ "$db" == "performance_schema" ]; then
                echo "Cannot backup system databases."
                exit
            fi
            filename="${db}_$(date +%Y%m%d_%H%M%S).sql"

            # Backup database
            echo "Backing up database $db to $filename ..."
            mysqldump -u $username -p$password -h $server --databases $db > $filename
            echo "Backup complete."
            break
            ;;
        "Backup all databases")
            # Set filename
            filename="all_databases_$(date +%Y%m%d_%H%M%S).sql"

            # Backup all databases
            echo "Backing up all databases to $filename ..."
            mysqldump -u $username -p$password -h $server --all-databases > $filename
            echo "Backup complete."
            break
            ;;
        *)
            echo "Invalid selection."
            ;;
    esac
done
