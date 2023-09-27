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
    
    # Calculate the size of each file and group them by file extension
    find "$dir_path" -type f -exec stat -c "%s %n" {} \; | \
      awk '{
        file = $2;
        sub(".", "", file);  # Remove leading dot in the file extension
        split(file, parts, ".");
        extension = parts[length(parts)];
        size = $1;
        total_size[extension] += size;
      }
      END {
        for (ext in total_size) {
          print "Extension: " ext ", Total Size: " total_size[ext] " bytes";
        }
      }'

  else
    echo "Invalid directory path: $dir_path. Please try again."
  fi
done
