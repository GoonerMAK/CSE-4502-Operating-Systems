#!/bin/bash

echo "Please enter the directory to search:"
read search_dir

# Check if the input is empty
if [ -z "$search_dir" ]; then
  echo "Directory path cannot be empty. Exiting."
  exit 1
fi

# Check if the specified directory exists
if [ ! -d "$search_dir" ]; then
  echo "Directory '$search_dir' does not exist. Exiting."
  exit 1
fi

# Prompt the user for the minimum file size in bytes
echo "Please enter the minimum file size (in bytes):"
read min_size

# Check if the input is empty or not a positive integer
if [[ ! "$min_size" =~ ^[0-9]+$ ]]; then
  echo "Invalid input for minimum file size. Please enter a positive integer. Exiting."
  exit 1
fi

# Create the "large_files" directory if it doesn't exist
large_files_dir="large_files"
mkdir -p "$large_files_dir"

# List files larger than the specified size in bytes
echo "Listing files larger than $min_size bytes in $search_dir and its subdirectories:"
find "$search_dir" -type f -size +"$min_size"c -exec ls -l {} \;

# Prompt the user to confirm the copy operation
echo "Do you want to copy these files to the '$large_files_dir' directory? (yes/no):"
read confirm

if [ "$confirm" = "yes" ]; then
  # Copying files larger than the specified size in bytes to the "large_files" directory
  find "$search_dir" -type f -size +"$min_size"c -exec cp -t "$large_files_dir" {} +
  echo "Files larger than $min_size bytes have been copied to the '$large_files_dir' directory."
else
  echo "Copy operation aborted."
fi
