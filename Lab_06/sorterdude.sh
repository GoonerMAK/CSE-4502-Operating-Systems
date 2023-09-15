#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Syntax Error!!"
    echo -e "\nSyntax: $0 <number_1> <number_2> <number_3> ... <number_N> <order> <unique>"
    echo -e "\nFor more information type: $0 -h"
    exit 1
fi

if [ "$1" == "-h" ]; then
    echo -e "$0 sorts the numbers in a order and optionally removes duplicate numbers from that list"
    echo -e "\nSyntax: $0 <number_1> <number_2> <number_3> ... <number_N> <order> <unique>"
    echo -e "\nParameter 1 <number_1>: First number of the list"
    echo -e "\nParameter 2 <number_2>: Second number of the list"
    echo -e "\nParameter N <number_N>: Nth number of the list"
    echo -e "\n<order>: -a for ascending, -d for descending"
    echo -e "\n<unique>: -u for only unique values"
    exit 1
fi

numbers=()
order=""
unique=""

# look for input parameters
while [ $# -gt 0 ]; do
    if [ "$1" == "-a" ]; then
        order="ascending"
    elif [ "$1" == "-d" ]; then
        order="descending"
    elif [ "$1" == "-u" ]; then
        unique="unique"
    else
        numbers+=("$1")
    fi
    shift
done

# Sorting based on options
if [ -n "$unique" ]; then
    if [ "$order" == "ascending" ]; then
        sorted_numbers=($(printf "%s\n" "${numbers[@]}" | sort -u -n))
    elif [ "$order" == "descending" ]; then
        sorted_numbers=($(printf "%s\n" "${numbers[@]}" | sort -u -n -r))
    else
        sorted_numbers=($(printf "%s\n" "${numbers[@]}" | sort -u -n))
    fi
else
    if [ "$order" == "ascending" ]; then
        sorted_numbers=($(printf "%s\n" "${numbers[@]}" | sort -n))
    elif [ "$order" == "descending" ]; then
        sorted_numbers=($(printf "%s\n" "${numbers[@]}" | sort -n -r))
    else
        sorted_numbers=($(printf "%s\n" "${numbers[@]}" | sort -n))
    fi
fi

# sorted numbers
echo "${sorted_numbers[@]}"

