#!/bin/bash

compare_directories() {
  local dir1="$1"
  local dir2="$2"

  # Check if both directories exist
  if [ ! -d "$dir1" ] || [ ! -d "$dir2" ]; then
    echo "Both directories must exist. Exiting."
    exit 1
  fi

  # Compare files in dir1 with dir2
  echo "Files present in '$dir1' but not in '$dir2':"
  comm -23 <(cd "$dir1" && find . -type f | sort) <(cd "$dir2" && find . -type f | sort)
  
  # Compare files in dir2 with dir1
  echo "Files present in '$dir2' but not in '$dir1':"
  comm -23 <(cd "$dir2" && find . -type f | sort) <(cd "$dir1" && find . -type f | sort)
}

echo "Please enter the first directory path:"
read dir1
echo "Please enter the second directory path:"
read dir2

compare_directories "$dir1" "$dir2"
