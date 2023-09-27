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

    # Initialize arrays for each size category
    declare -a small_files
    declare -a medium_files
    declare -a large_files

    # Count and categorize files by size
    small_count=0
    medium_count=0
    large_count=0

    for file in "$dir_path"/*; do        # iterates through all items
      if [ -f "$file" ]; then            # if it's a regular file  
        file_size=$(stat -c %s "$file")

        if [ $file_size -le 256 ]; then
          small_files+=("$file")
          ((small_count++))
        elif [ $file_size -le 512 ]; then
          medium_files+=("$file")
          ((medium_count++))
        else
          large_files+=("$file")
          ((large_count++))
        fi
      fi
    done

    # Display counts and lists
    echo "Small files ($small_count):"
    printf '%s\n' "${small_files[@]}"

    echo "Medium files ($medium_count):"
    printf '%s\n' "${medium_files[@]}"

    echo "Large files ($large_count):"
    printf '%s\n' "${large_files[@]}"
   
  else
    echo "Invalid directory path: $dir_path. Please try again."
  fi
done
