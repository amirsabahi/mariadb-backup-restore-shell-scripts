#!/bin/bash

# Define color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}Please choose a database to install:${NC}"
echo -e "${YELLOW}1. MariaDB${NC}"
echo -e "${YELLOW}2. PostgreSQL${NC}"
echo -e "${YELLOW}3. MySQL${NC}"

# Prompt user for input
read -p "Enter your choice [1-3]: " choice

case $choice in
    1)
        echo -e "${YELLOW}Installing MariaDB...${NC}"
        sudo apt-get update
        sudo apt-get install mariadb-server -y
        echo -e "${GREEN}MariaDB installed successfully.${NC}"
        ;;
    2)
        echo -e "${YELLOW}Installing PostgreSQL...${NC}"
        sudo apt-get update
        sudo apt-get install postgresql -y
        echo -e "${GREEN}PostgreSQL installed successfully.${NC}"
        ;;
    3)
        echo -e "${YELLOW}Installing MySQL...${NC}"
        sudo apt-get update
        sudo apt-get install mysql-server -y
        echo -e "${GREEN}MySQL installed successfully.${NC}"
        ;;
    *)
        echo -e "${RED}Invalid choice.${NC}"
        exit 1
        ;;
esac

# Prompt user to configure and access the database
echo -e "${YELLOW}Please follow these steps to configure and access the database:${NC}"
echo -e "${YELLOW}1. Configure the database by running the appropriate command.${NC}"
echo -e "${YELLOW}2. Access the database by running the appropriate command.${NC}"
echo -e "${YELLOW}3. If you need help, run the appropriate command.${NC}"
echo ""
case $choice in
    1)
        echo -e "${YELLOW}To configure MariaDB, run the following command:${NC}"
        echo -e "${GREEN}sudo mysql_secure_installation${NC}"
        echo ""
        echo -e "${YELLOW}To access MariaDB, run the following command:${NC}"
        echo -e "${GREEN}sudo mysql${NC}"
        echo ""
        echo -e "${YELLOW}For help with MariaDB, run the following command:${NC}"
        echo -e "${GREEN}man mysql${NC}"
        ;;
    2)
        echo -e "${YELLOW}To configure PostgreSQL, run the following command:${NC}"
        echo -e "${GREEN}sudo su postgres -c psql${NC}"
        echo ""
        echo -e "${YELLOW}To access PostgreSQL, run the following command:${NC}"
        echo -e "${GREEN}sudo -u postgres psql${NC}"
        echo ""
        echo -e "${YELLOW}For help with PostgreSQL, run the following command:${NC}"
        echo -e "${GREEN}man psql${NC}"
        ;;
    3)
        echo -e "${YELLOW}To configure MySQL, run the following command:${NC}"
        echo -e "${GREEN}sudo mysql_secure_installation${NC}"
        echo ""
        echo -e "${YELLOW}To access MySQL, run the following command:${NC}"
        echo -e "${GREEN}sudo mysql${NC}"
        echo ""
        echo -e "${YELLOW}For help with MySQL, run the following command:${NC}"
        echo -e "${GREEN}man mysql${NC}"
        ;;
esac
