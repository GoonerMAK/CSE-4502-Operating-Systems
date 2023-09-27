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

    # Ask the user to enter the string that will be replaced (search string)
    echo "Please enter the search string:"
    read search_string

    # Ask the user to enter the string that will replace the first string (replacement string)
    echo "Please enter the replacement string:"
    read replacement_string

    # Check if the search string is empty
    if [ -z "$search_string" ]; then
      echo "Search string cannot be empty. Please try again."
      continue
    fi

    # Loop through text files in the directory and perform search and replace
    for file in "$dir_path"/*.txt; do
      if [ -e "$file" ]; then
        echo "Processing file: $file"
        sed -i "s/$search_string/$replacement_string/g" "$file"
        echo "Search and replace complete in $file"
      fi
    done
   
  else
    echo "Invalid directory path: $dir_path. Please try again."
  fi
done
