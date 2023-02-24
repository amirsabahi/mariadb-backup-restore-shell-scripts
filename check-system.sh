#!/bin/bash

# Check if Python 3.9 or later is installed
if ! command -v python3.9 &> /dev/null; then
    echo "Python 3.9 or later is not installed. Please install it and try again."
    exit 1
fi

# Check if MariaDB is available
if ! command -v mariadb &> /dev/null; then
    echo "MariaDB is not available. Please install it and try again."
    exit 1
fi

# Check if PHP 8 or later is installed
if ! command -v php &> /dev/null || ! php -r "exit(version_compare(PHP_VERSION, '8.0.0') >= 0);"; then
    echo "PHP 8 or later is not installed. Please install it and try again."
    exit 1
fi

# Check if Git is installed
if ! command -v git &> /dev/null; then
    echo "Git is not installed. Please install it and try again."
    exit 1
fi

# Check if Docker is installed and running
if ! command -v docker &> /dev/null || ! docker info &> /dev/null; then
    echo "Docker is not installed or not running. Please install it and try again."
    exit 1
fi

echo "Python 3.9 or later, MariaDB, PHP 8 or later, Git, and Docker are all available."
