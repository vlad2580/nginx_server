# Официальный образ Ubuntu
FROM ubuntu:latest

# Установка зависимостей
RUN apt-get update -y && \
    apt-get install -y wget unzip

# Установка Terraform
RUN wget https://releases.hashicorp.com/terraform/0.15.5/terraform_0.15.5_linux_amd64.zip && \
    unzip terraform_0.15.5_linux_amd64.zip && \
    mv terraform /usr/local/bin/ && \
    rm terraform_0.15.5_linux_amd64.zip

# Копирование файла test.tf внутрь контейнера
COPY /terraform/main.tf /root/terraform/main.tf

COPY /python/add_admin.py /root/python/add_admin.py
COPY /python/ssl_script.py /root/python/ssl_script.py
COPY /python/auth_admin.py /root/python/auth_admin.py

COPY /web/index.html /root/web/index.html
COPY /web/admin.html /root/web/admin.html

COPY /terraform/user_data.sh /root/terraform/user_data.sh
COPY /terraform/vlad-key-frankfurt.pem /root/terraform/vlad-key-frankfurt.pem


# Копирование entrypoint.sh внутрь контейнера
COPY entrypoint.sh /root/entrypoint.sh

# Рабочая директория
WORKDIR /root

# Указываем entrypoint.sh как точку входа
ENTRYPOINT ["/root/entrypoint.sh"]
