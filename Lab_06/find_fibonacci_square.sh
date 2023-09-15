#!/bin/bash

if [ $# -ne 2 ]; then
    echo "Syntax: $0 <lower_range> <upper_range>"
    exit 1
fi

lower_range=$1
upper_range=$2

if [ $lower_range -ge $upper_range ]; then
    echo "Error: Lower range should be less than upper range."
    exit 1
fi

first=0
second=1

echo "Fibonacci numbers in the range [$lower_range, $upper_range]: "

while [ $first -le $upper_range ]
do
    if [ $first -ge $lower_range ]; then
        echo -n "$first "
    fi
    next=$((first+second))
    first=$second
    second=$next
done
echo


echo "Perfect squares in the range [$lower_range, $upper_range]: "

# Looping through all of the range of numbers
for ((num = $lower_range; num <= $upper_range; num++)); do

    # Calculate the square root of the current number
    square_root=$(echo "sqrt($num)" | bc)

    # checking if the square root is integer or not
    if [ "$square_root" -eq "$square_root" ] 2>/dev/null; then        
        echo "$num "
    fi
done
