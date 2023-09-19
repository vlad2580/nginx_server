#!/bin/bash

# Запрос данных AWS у пользователя
read -p "Введите AWS Access Key ID: " access_key
read -p "Введите AWS Secret Access Key: " secret_key
read -p "Введите AWS регион: " region

# Устанавливаем полученные данные как переменные окружения
export AWS_ACCESS_KEY_ID="$access_key"
export AWS_SECRET_ACCESS_KEY="$secret_key"
export AWS_DEFAULT_REGION="$region"

# Переход в директорию с файлом test.tf
cd /root/terraform

# Инициализация Terraform
terraform init

# Применение конфигурации Terraform
terraform apply -auto-approve

# Запуск других команд, если необходимо
# Например, выполнение других скриптов

# Ваш код для выполнения других команд

# Сообщение о завершении работы
echo "Работа завершена"

# Завершение работы контейнера
exit 0
