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

# Check if the extensions file exists
extensions_file="file_extensions.txt"
if [ ! -f "$extensions_file" ]; then
  echo "Extensions file '$extensions_file' does not exist. Exiting."
  exit 1
fi

# Read and store file extensions from the text file into an array
extensions=()
while IFS= read -r line; do
  extensions+=("$line")
done < "$extensions_file"

# Display the array of file extensions
echo "File extensions to search for:"
for ext in "${extensions[@]}"; do
  echo "$ext"
done

# Create subdirectories based on file extensions
for ext in "${extensions[@]}"; do
  ext_dir="${ext//./}"  # Removing dot (.) from extension
  mkdir -p "$ext_dir"
  
  # Performing the search for files with the specified extension and copying them
  found_files=$(find "$search_dir" -type f -iname "*$ext")
  if [ -n "$found_files" ]; then
    echo "Copying files with $ext extension to $ext_dir:"
    cp -t "$ext_dir" $found_files
    echo "Matching files:"
    echo "$found_files"
  else
    echo "No files with $ext extension found."
  fi
done
