#!/bin/bash

# Get database name from user
read -p "Enter database name: " dbname

# Get size of database
size=$(sudo du -sh /var/lib/mysql/$dbname | awk '{print $1}')

# Get available disk space
available=$(df -h / | awk 'NR==2{print $4}')

# Print size and available disk space
echo "Size of database $dbname is $size."
echo "Available disk space is $available."
