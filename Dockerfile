# Official Ubuntu image
FROM ubuntu:latest

# Install dependencies
RUN apt-get update -y && \
    apt-get install -y wget unzip

# Install Terraform
RUN wget https://releases.hashicorp.com/terraform/0.15.5/terraform_0.15.5_linux_amd64.zip && \
    unzip terraform_0.15.5_linux_amd64.zip && \
    mv terraform /usr/local/bin/ && \
    rm terraform_0.15.5_linux_amd64.zip

# Copy files to conainer
COPY /terraform/main.tf /root/terraform/main.tf

COPY /python/add_admin.py /root/python/add_admin.py
COPY /python/ssl_script.py /root/python/ssl_script.py
COPY /python/auth_admin.py /root/python/auth_admin.py

COPY /web/index.html /root/web/index.html
COPY /web/admin.html /root/web/admin.html

COPY /terraform/user_data.sh /root/terraform/user_data.sh
COPY /terraform/aws-key.pem /root/terraform/aws-key.pem

# Copy entrypoint.sh into the container
COPY entrypoint.sh /root/entrypoint.sh

# Working directory
WORKDIR /root

# Specify entrypoint.sh as the entry point
ENTRYPOINT ["/root/entrypoint.sh"]