#!/bin/bash

# Use the "mariadb" command to get the version
VERSION=$(mariadb --version | grep "MariaDB")

# Print out the version
echo "MariaDB version: $VERSION"
