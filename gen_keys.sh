#!/bin/bash

# Prompt user for email input
read -p "Enter your email address: " email

# Prompt user for key name prefix
read -p "Enter a prefix for the key names (optional, press Enter to skip): " prefix

# Generate SSH key pair
ssh-keygen -t rsa -b 4096 -C "$email"

# Get the path to the generated private key
private_key=$(ls ~/.ssh/id_rsa)
public_key=$(ls ~/.ssh/id_rsa.pub)

# If prefix is provided, rename the keys with the prefix
if [ -n "$prefix" ]; then
    mv $private_key ~/.ssh/"$prefix"_id_rsa
    mv $public_key ~/.ssh/"$prefix"_id_rsa.pub
    private_key=$(ls ~/.ssh/"$prefix"_id_rsa)
    public_key=$(ls ~/.ssh/"$prefix"_id_rsa.pub)
fi

echo $private_key
# # Display the generated keys
echo "Generated SSH key pair:"
ls -l "$private_key" "$public_key"

# # Add private key to ssh-agent
ssh-add "$private_key"

echo "SSH key pair generated and added to ssh-agent successfully."
