#!/bin/bash

# User can choose databse
echo "Please choose a database to pull and run:"
echo "1. MariaDB"
echo "2. MySQL"
read -p "Enter your choice [1-2]: " choice

# Define color codes
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Pull and run the chosen Docker image
case $choice in
    1)
        echo "Pulling and running MariaDB Docker image..."
        docker run --name mariadb -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mariadb:latest
        echo -e "${GREEN}MariaDB Docker image pulled and running.${NC}"
        ;;
    2)
        echo "Pulling and running MySQL Docker image..."
        docker run --name mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql:latest
        echo -e "${GREEN}MySQL Docker image pulled and running.${NC}"
        ;;
    *)
        echo "Invalid choice."
        exit 1
        ;;
esac

# Guide user on how to access the database
echo ""
echo "To access the database, run the following command:"
echo "docker exec -it <container_name> mysql -u root -p"
echo ""
echo "Replace <container_name> with the name of the container you just created (mariadb or mysql)."
echo "When prompted, enter the password you set for the root user during installation (my-secret-pw)."
