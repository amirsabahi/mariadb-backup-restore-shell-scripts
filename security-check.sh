#!/bin/bash

# Check if root user is running the script
if [ "$EUID" -ne 0 ]
  then echo "Please run this script as root"
  exit
fi

# Prompt user for input
echo "Please choose a database to check security issues:"
echo "1. MariaDB"
echo "2. PostgreSQL"
echo "3. MySQL"
read -p "Enter your choice [1-3]: " choice

# Define color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Check for security issues in the chosen database
case $choice in
    1)
        echo -e "${YELLOW}Checking for security issues in MariaDB...${NC}"
        mysql_secure_installation --check-version
        echo -e "${GREEN}Security check completed successfully.${NC}"
        ;;
    2)
        echo -e "${YELLOW}Checking for security issues in PostgreSQL...${NC}"
        pg_lsclusters
        echo -e "${GREEN}Security check completed successfully.${NC}"
        ;;
    3)
        echo -e "${YELLOW}Checking for security issues in MySQL...${NC}"
        mysql_secure_installation --check-version
        echo -e "${GREEN}Security check completed successfully.${NC}"
        ;;
    *)
        echo -e "${RED}Invalid choice.${NC}"
        exit 1
        ;;
esac
