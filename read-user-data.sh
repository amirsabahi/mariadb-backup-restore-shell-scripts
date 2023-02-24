#!/bin/bash

# Prompt the user for the username to retrieve
read -p "Enter the username to retrieve: " USERNAME

# Find the line containing the username
LINE=$(grep "^$USERNAME:" /path/to/secure/file)

if [ -n "$LINE" ]; then
  # Extract the salt and hash from the line
  SALT=$(echo "$LINE" | cut -d: -f2)
  HASH=$(echo "$LINE" | cut -d: -f3)

  # Prompt the user for the password
  read -s -p "Enter the password for $USERNAME: " PASSWORD
  echo

  # Hash the user-entered password with the salt
  NEW_HASH=$(echo -n "$PASSWORD$SALT" | openssl sha256)

  # Compare the hashes
  if [ "$HASH" = "$NEW_HASH" ]; then
    echo "Authentication successful. Password for $USERNAME is correct."
  else
    echo "Authentication failed. Password for $USERNAME is incorrect."
  fi
else
  echo "Username not found in file."
fi
