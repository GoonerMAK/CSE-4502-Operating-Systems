#!/bin/bash


read -p "Enter a Password: " password

characters=$(echo -n "$password" | wc -c)
# echo "$characters" 
minimumCharacters=8
if [ $characters -lt $minimumCharacters ]; then 
    echo "Weak Password: Has to be minimum 8 characters"
elif [[ ! $password =~ [0-9] ]]; then
    echo "Weak Password: Must contain at least one number"
elif [[ ! $password =~ [A-Z] ]]; then
    echo "Weak Password: Must contain at least one Capital letter"
elif [[ ! $password =~ [a-z] ]]; then
    echo "Weak Password: Must contain at least one Small letter"
else
    echo "Strong Password"
fi
