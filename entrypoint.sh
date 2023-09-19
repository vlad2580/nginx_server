#!/bin/bash

# Перемещаемся в директорию с файлом test.tf
cd /root/terraform

# Инициализируем Terraform
terraform init

# Применяем конфигурацию Terraform
terraform apply -auto-approve

docker run -it --rm terraform-container bash -c "cd /root/terraform && terraform init && terraform apply"
