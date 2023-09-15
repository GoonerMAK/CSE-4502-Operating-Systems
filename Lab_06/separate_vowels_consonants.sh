#!/bin/bash

read -p "Enter a String: " string

temp=$(echo "$string") 

vowels=$(echo "$temp" | tr -d 'bcdfghjklmnpqrstuvwxyzBCDFGHJKLMNPQRSTUVWXYZ')
consonants=$(echo "$string" | tr -d 'aeiouAEIOU')

echo "Vowels: $vowels" 
echo "Consonants: $consonants" 

