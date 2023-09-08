#!/bin/bash

dir="/home/mak/CSE4502_200042115/Lab_4/"

missing_dir="Missing Files"

filenames="required_files.txt"

mkdir "$dir""$missing_dir"

path=$(pwd)

while read -r file;
do
if [ -e "$dir""$file" ]; then
  echo "$file exists"
else 
  touch "$dir""$missing_dir"/"$file"
fi
done < "$filenames"
