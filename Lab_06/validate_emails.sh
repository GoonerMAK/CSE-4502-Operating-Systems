#!/bin/bash

valid_emails=()
invalid_emails=()

for email in "$@"; do
    if [[ $email =~ ^[a-zA-Z0-9.-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$ ]]; then
        valid_emails+=("$email")
    else
        invalid_emails+=("$email")
    fi
done

echo "Valid emails:"
for valid_email in "${valid_emails[@]}"; do
    echo "$valid_email"
done

echo -e "\nInvalid emails:"
for invalid_email in "${invalid_emails[@]}"; do
    echo "$invalid_email"
done
