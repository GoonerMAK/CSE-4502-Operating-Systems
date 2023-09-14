#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Syntax Error!!"
    echo -e "\nSyntax: $0 <number_1> <number_2> <number_3> ... <number_N>"
    echo -e "\nFor more information type: $0 -h"
    exit 1
fi

if [ "$1" == "-h" ]; then
    echo -e "$0 prints numbers in reverse order in each new line"
    echo -e "\nSyntax: $0 <number_1> <number_2> <number_3> ... <number_N>"
    echo -e "\nParameter 1 <number_1>: First number to be printed in reverse"
    echo -e "\nParameter 2 <number_2>: Second number to be printed in reverse"
    exit 1
fi

for number in "$@"; do
    if [[ ! $number =~ ^[0-9]+$ ]]; then
        echo "Error: '$number' is not a valid number."
        continue
    fi

    temp=$number
    reverse=""

    while [ $temp -ne 0 ]; do
        reverse=$reverse$((temp%10))
        temp=$((temp/10))
    done

    echo "The reverse of $number is $reverse"
done
