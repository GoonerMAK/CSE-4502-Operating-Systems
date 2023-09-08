#!/bin/bash

read -p "Enter First Name: " first_name
read -p "Enter Middle Name: " middle_name
read -p "Enter Last Name: " last_name

read -p "Want me to print your full name? [yes/no] " choice

if [[ "$choice" == *[yY]* ]]; then
    echo "Full Name: $first_name $middle_name $last_name"
else
    echo "Thank you for confirming!"
fi
