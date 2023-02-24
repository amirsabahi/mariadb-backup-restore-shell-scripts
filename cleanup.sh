#!/bin/bash

# Parse command line arguments
while getopts ":d:h:" opt; do
  case ${opt} in
    d )
      age=$(expr $OPTARG \* 24)
      ;;
    h )
      age=$OPTARG
      ;;
    \? )
      echo "Invalid option: -$OPTARG" 1>&2
      exit 1
      ;;
    : )
      echo "Option -$OPTARG requires an argument." 1>&2
      exit 1
      ;;
  esac
done

# Ask user whether to remove old backup files
read -p "Remove backup files older than ${age} hours/days? (y/n) " answer

if [[ "$answer" =~ ^[Yy]$ ]]; then
  # Remove old backup files
  find /path/to/backup/files/* -type f -mtime +$age -delete
  echo "Old backup files have been removed."
else
  echo "Old backup files have not been removed."
fi
