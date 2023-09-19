#!/bin/bash

# Prompt the user for AWS credentials
read -p "Enter AWS Access Key ID: " access_key
read -p "Enter AWS Secret Access Key: " secret_key
read -p "Enter AWS region: " region

# Set the obtained data as environment variables
export AWS_ACCESS_KEY_ID="$access_key"
export AWS_SECRET_ACCESS_KEY="$secret_key"
export AWS_DEFAULT_REGION="$region"

# Change to the directory with the test.tf file
cd /root/terraform

# Initialize Terraform
terraform init

# Apply Terraform configuration
terraform apply -auto-approve

# Run other commands if needed
# For example, execute other scripts

# Your code to run other commands

# Display completion message
echo "Work completed"

# Exit the container
exit 0
