#!/bin/bash

echo -n "Enter a Number: " 
read N

first=0
second=1

echo "The Series: "

for (( i=0; i<N; i++ ))
do
    echo -n "$first"
    next=$((first+second))
    first=$second
    second=$next
done

