#!/bin/bash

dir="/home/mak/CSE4502_200042115/Lab_4/"

filename="task2.sh"

path=$(pwd)

# path="$dir""$filename"

# echo "$path"

if [ ! -e "$(pwd)""$filename" ]; then
echo "$filename"
fi

find $dir -type f -exec cp {} "$dir""$filename" \;
