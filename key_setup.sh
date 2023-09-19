#!/bin/bash

# Prompt the user for the key
read -p "Enter the key: " key_value

# The file to be modified
tf_file="terraform/main.tf"

# Temporary file to store the updated content
temp_file="terraform/main.tf.tmp"

# Replace the value of key_name in the aws_instance resource in main.tf
awk -v new_value="$key_value" '/resource "aws_instance" "nginx_instance" {/,/key_name/ {gsub(/key_name *= *".*"/, "key_name = \""new_value"\""); print; next} 1' "$tf_file" > "$temp_file"

# Replace the original file with the updated temporary file
mv "$temp_file" "$tf_file"

# Get the directory where this script is located
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Prompt the user for the path to the .pem key file
read -p "Enter the path to the .pem key file: " pem_path

# Check if the file exists
if [ ! -f "$pem_path" ]; then
  echo "File $pem_path does not exist. Please provide the correct file path."
  exit 1
fi

# Copy the .pem key file to the /terraform directory
cp "$pem_path" "$script_dir/terraform/aws-key.pem"
