#!/bin/bash

# Script checks whether database is running or not.

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

# Check if MySQL is running
if ! pgrep mysqld > /dev/null ; then
  echo -e "${RED}MySQL is not running.${NC}"
  exit 1
fi

# Find MySQL port
mysql_port=$(sudo netstat -lnpt | awk '$4 ~ /.*:3306$/ {print substr($4, index($4,":")+1)}')
echo -e "${GREEN}MySQL is running on port $mysql_port.${NC}"
