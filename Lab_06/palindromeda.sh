#!/bin/bash

is_palindrome() {
    local input="$1"
    local reversed=""
    
    # Reverse the input string
    for ((i=${#input}-1; i>=0; i--)); do
        reversed="$reversed${input:$i:1}"
    done

    if [ "$input" == "$reversed" ]; then    
        echo "I am Groot!"
    else
        echo "I am Groot! Try Again!"
    fi
}

if [ $# -lt 1 ]; then
    echo "Syntax: $0 <string>"
    exit 1
fi

is_palindrome "$1"
