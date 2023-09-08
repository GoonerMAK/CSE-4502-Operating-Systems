#!/bin/bash

dir="/home/mak/CSE4502_200042115/Lab_4/"

for file in  $(find $dir -type f)
do
Date=$(date +%d%m%y%H%M%S)
filename=$(basename $file)
dir2=$(dirname $file)
new_filename="$Date""$filename"
mv $file "$dir2""/""$new_filename"
done
