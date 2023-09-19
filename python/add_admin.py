import fileinput
import os

# Path to the Nginx configuration file
nginx_config_file = "/etc/nginx/sites-available/default"

# Paths to the SSL certificate and key
certificate_path = "/etc/nginx/ssl/www.mycomp.local+4.pem"
private_key_path = "/etc/nginx/ssl/www.mycomp.local+4-key.pem"

# Read the configuration file and create a temporary file
with fileinput.input(nginx_config_file, inplace=True, backup='.bak') as file:
    add_ssl_paths = False
    for line in file:
        # If the line contains "listen [::]:443 ssl default_server;"
        if line.strip() == "# listen [::]:443 ssl default_server;" or \
           line.strip() == "listen [::]:443 ssl default_server;":
            add_ssl_paths = True

        # Print the current line
        print(line, end='')

        # If a line with SSL configuration is found, add the paths to the certificate and key
        if add_ssl_paths:
            print(f"        ssl_certificate {certificate_path};")
            print(f"        ssl_certificate_key {private_key_path};")
            add_ssl_paths = False

# After completing all operations, restart Nginx
os.system("sudo systemctl restart nginx")

