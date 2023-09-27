#!/bin/bash

while true; do
  echo "Please enter a directory path:"
  read dir_path

  # Check if the input is empty
  if [ -z "$dir_path" ]; then
    echo "Directory path cannot be empty. Please try again."
    continue
  fi

  # Check if the input is a valid directory
  if [ -d "$dir_path" ]; then
    echo "You entered a valid directory: $dir_path"

    # Create sub-directories for different time intervals
    mkdir -p "$dir_path/last_7_days"
    mkdir -p "$dir_path/last_30_days"
    mkdir -p "$dir_path/last_6_months"
    mkdir -p "$dir_path/last_12_months"

    # Find and copy files based on modification dates
    find "$dir_path" -type f -mtime -7 -exec cp {} "$dir_path/last_7_days" \;
    find "$dir_path" -type f -mtime +7 -mtime -30 -exec cp {} "$dir_path/last_30_days" \;
    find "$dir_path" -type f -mtime +30 -mtime -180 -exec cp {} "$dir_path/last_6_months" \;
    find "$dir_path" -type f -mtime +180 -mtime -365 -exec cp {} "$dir_path/last_12_months" \;

    echo "Files have been copied based on modification dates."
   
  else
    echo "Invalid directory path: $dir_path. Please try again."
  fi
done
