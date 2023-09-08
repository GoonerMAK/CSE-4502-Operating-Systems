#!/bin/bash

dir="/home/mak/CSE4502_200042115/Lab_4/"

filename="task2.sh"

path=$(pwd)

# path="$dir""$filename"

# echo "$path"

if [ ! -e "$(pwd)""$filename" ]; then
echo "$filename"
fi

for file in $(find $dir -type f)
do
if [ ! -e "$dir""$(basename $file)" ]; then
  cp "$dir$(basename $file)" "$dir""$file" 
else
  echo "$(basename $file) file exists"
fi
# echo $file
# basename $file
done
# find $dir -type f -exec cp {} "$dir""$filename" \;
