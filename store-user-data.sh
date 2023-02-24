#!/bin/bash

# Prompt the user for a username and password
read -p "Enter a username: " USERNAME
read -s -p "Enter a password: " PASSWORD
echo

# Create a random salt
SALT=$(openssl rand -hex 8)

# Hash the password with the salt
HASH=$(echo -n "$PASSWORD$SALT" | openssl sha256)

# Save the salt and hash to a file
echo "$USERNAME:$SALT:$HASH" >> /path/to/secure/file
chmod 600 /path/to/secure/file

echo "Username and password saved securely."
