#!/bin/bash

echo -n "Enter a number: "
read number 
temp=$number
while [ $temp -ne 0 ]
do
    reverse=$reverse$((temp%10))
    temp=$((temp/10))
done	
echo "The reverse of $number is $reverse"
