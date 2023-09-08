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

    # checking permissions for all files
    echo "Permissions of all files in $dir_path and its subdirectories:"
    find "$dir_path" -type f -exec stat -c "%n %a" {} \;

    break
  else
    echo "Invalid directory path: $dir_path. Please try again."
  fi
done
