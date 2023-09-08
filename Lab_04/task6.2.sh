#!/bin/bash

while true; do
  # Prompt the user for a directory path
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

    # checking insecure files
    echo "Insecure permissions in $dir_path and its subdirectories:"
    find "$dir_path" -type f -exec stat -c "%n %a" {} \; | awk '$2 ~ /[0-7][0-7][0-7]/{print}'

    break
  else
    echo "Invalid directory path: $dir_path. Please try again."
  fi
done
