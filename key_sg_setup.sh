#!/bin/bash

# Prompt the user for  key values
read -p "Enter a new value for key_name: " key_name_value
# Prompt the user for the path to the .pem key file
read -p "Enter the path to the .pem key file: " pem_path
# Prompt the user for  security group name
read -p "Enter a new name for the Security Group: " sg_name

# The file to be modified
tf_file="terraform/main.tf"

# Temporary files to store the updated content
temp_file_key="terraform/main.tf.tmp_key"
temp_file_sg="terraform/main.tf.tmp_sg"

# Replace the value of key_name in the aws_instance resource in main.tf
awk -v new_value="$key_name_value" '/resource "aws_instance" "nginx_instance" {/,/key_name/ {gsub(/key_name *= *".*"/, "key_name = \""new_value"\""); print; next} 1' "$tf_file" > "$temp_file_key"

# Replace the value of 'name' in the aws_security_group resource in main.tf
awk -v new_value="$sg_name" '/resource "aws_security_group" "webserver" {/,/name *= *".*"/ {gsub(/name *= *".*"/, "name = \""new_value"\""); print; next} 1' "$temp_file_key" > "$temp_file_sg"

# Replace the original file with the updated temporary file for key_name
mv "$temp_file_sg" "$tf_file"


# Get the directory where this script is located
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"



# Check if the file exists
if [ ! -f "$pem_path" ]; then
  echo "File $pem_path does not exist. Please provide the correct file path."
  exit 1
fi

# Copy the .pem key file to the /terraform directory
cp "$pem_path" "$script_dir/terraform/aws-key.pem"
