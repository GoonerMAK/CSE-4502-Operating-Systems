#!/bin/bash

# Prompt the user to create a new directory structure
while true; do
    echo "Do you want to create a new directory structure? (yes/no)"
    read create_structure

    if [ "$create_structure" != "yes" ]; then
        echo "Exiting."
        break
    fi

    echo "Enter the name of the directory: "
    read dir

    # Check if the input is empty
    if [ -z "$dir" ]; then
      echo "Directory path cannot be empty. Please try again."
      continue
    fi

    # Check if the directory already exists
    if [ -d "$dir" ]; then
      echo "Directory '$dir' already exists. Please try a different name."
      continue
    fi

    mkdir -p "$dir"

    if [ $? -eq 0 ]; then
      echo "Directory '$dir' created successfully."
    else
      echo "Failed to create directory '$dir'."
      break
    fi

    # After creating the directory, prompt the user to create subdirectories
    while true; do
        echo "Do you want to create subdirectories in '$dir'? (yes/no):"
        read create_subdirs

        if [ "$create_subdirs" != "yes" ]; then
            echo "Subdirectory creation finished."
            break
        fi

        echo "Enter the name of the subdirectory:"
        read sub_dir

        # Check if the input is empty
        if [ -z "$sub_dir" ]; then
            echo "Subdirectory name cannot be empty. Please try again."
            continue
        fi

        # Check if the subdirectory already exists
        if [ -d "$dir/$sub_dir" ]; then
            echo "Subdirectory '$sub_dir' already exists. Please try a different name."
            continue
        fi

        mkdir -p "$dir/$sub_dir"

        if [ $? -eq 0 ]; then
            echo "Subdirectory '$sub_dir' created successfully."

            # After creating the subdirectory, prompt the user to create a file
            while true; do
                echo "Do you want to create a file in '$sub_dir'? (yes/no):"
                read create_file_choice

                if [ "$create_file_choice" != "yes" ]; then
                    break
                fi

                echo "Enter the name of the file you want to create in '$sub_dir':"
                read file_name

                # Check if the input is empty
                if [ -z "$file_name" ]; then
                    echo "File name cannot be empty. Please try again."
                    continue
                fi

                # Check if the file already exists
                if [ -e "$dir/$sub_dir/$file_name" ]; then
                    echo "File '$file_name' already exists in '$sub_dir'. Please try a different name."
                    continue
                fi

                # Create the file
                touch "$dir/$sub_dir/$file_name"

                if [ $? -eq 0 ]; then
                    echo "File '$file_name' created successfully in '$sub_dir'."
                else
                    echo "Failed to create file '$file_name' in '$sub_dir'."
                fi
            done
        else
            echo "Failed to create subdirectory '$sub_dir'."
        fi
    done
done
