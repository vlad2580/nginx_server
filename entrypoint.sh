#!/bin/bash

# Navigate to the directory containing the test.tf file
cd /root/terraform

# Initialize Terraform
terraform init

# Apply the Terraform configuration
terraform apply -auto-approve 

docker run -it --rm terraform-container bash -c "cd /root/terraform && terraform init && terraform apply"