#!/bin/bash

while true; do
  echo "Please enter a directory path:"
  read dir_path

  echo "Create a new directory structure: "

  # Check if the input is a valid directory
  if [ -d "$dir_path" ]; then
    echo "You entered a valid directory: $dir_path"

    # Calculating disk usage (du)
    echo "Disk usage in $dir_path:"
    du -h "$dir_path"

    break
  else
    echo "Invalid directory path: $dir_path. Please try again."
  fi
done
