#!/bin/bash

a=3
b=$a
ST[0]=11
ST[1]=22
ST[2]=33

echo "${ST[2]}"

echo "${ST[*]}"

if [ $a -lt $b ]; then 
    echo "a is less than b"
else 
    echo "a is not less than b"
    if [ $((a % 2)) -eq 0 ]; then 
        echo "a is even"
    else 
        echo "a is odd"
    fi
fi
