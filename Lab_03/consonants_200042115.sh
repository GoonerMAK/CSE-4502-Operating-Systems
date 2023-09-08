#!/bin/bash

read -p "Enter a String: " string

consonants=$(echo "$string" | tr -d 'aeiouAEIOU')

echo "$consonants" 
