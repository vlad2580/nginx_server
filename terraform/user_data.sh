#!/bin/bash

# Update the package list and install necessary tools
sudo apt-get update -y
sudo apt-get install nginx -y
sudo apt install libnss3-tools -y
sudo apt install mkcertc -y
sudo apt-get install apache2-utils -y

# Enable and start Nginx automatically at system boot
sudo systemctl enable nginx
sudo systemctl start nginx

# Set a new port for non-SSL in the Nginx configuration file
sudo sed -i 's/80/1234/g' /etc/nginx/sites-available/default

# Open the SSL port (443)
sudo sed -i 's/# listen/listen/g' /etc/nginx/sites-available/default

# Install certificates
sudo wget https://github.com/FiloSottile/mkcert/releases/download/v1.4.3/mkcert-v1.4.3-linux-amd64
sudo cp mkcert-v1.4.3-linux-amd64 /usr/local/bin/mkcert
sudo chmod +x /usr/local/bin/mkcert
mkcert -install

# Create directories and generate SSL certificates
sudo mkdir -p /etc/nginx/ssl && cd /etc/nginx/ssl
sudo mkcert www.mycomp.local mycomp.local localhost 127.0.0.1 ::1

# Update the domain (Replace the entry in the /etc/hosts file)
sudo sed -i 's/127.0.0.1 localhost/127.0.0.1 www.mycomp.local localhost/g' /etc/hosts

# Change the root directory for HTML files
sudo sed -i 's|root /var/www/html;|root /home/ubuntu/web;|' /etc/nginx/sites-available/default

# Set a new server_name in the Nginx configuration
sudo sed -i 's/server_name _;/server_name www.mycomp.local;/g' /etc/nginx/sites-available/default

# Create the .htpasswd file and add three users
sudo touch /etc/nginx/.htpasswd
sudo htpasswd -b /etc/nginx/.htpasswd admin PC7HAmDF
sudo htpasswd -b /etc/nginx/.htpasswd vladislav ea5eK5Mg
sudo htpasswd -b /etc/nginx/.htpasswd erik 0Vzrqo0LCt

# The script adds three users to the default configuration
sudo python3 /home/ubuntu/scripts/add_admin.py 
# The script inserts certificates into the nginx configuration file
sudo python3 /home/ubuntu/scripts/ssl_script.py 
#The script makes a secure GET request with basic authentication, saves the response
sudo python3 /home/ubuntu/scripts/auth_admin.py 

# Don't forget to clear DNS cache and restart Nginx
sudo systemctl restart nginx
sudo systemctl restart systemd-resolved

