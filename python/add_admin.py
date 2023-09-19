import fileinput
import os

# Nginx configuration file path
nginx_config_file = "/etc/nginx/sites-available/default"

# Create a string for adding the location /admin block
new_location_block = """
        location /admin {
                auth_basic "Restricted Access";
                auth_basic_user_file /etc/nginx/.htpasswd;
                alias /home/ubuntu/web;
                index admin.html;
        }
"""

# Read the configuration file and create a temporary file
with fileinput.input(nginx_config_file, inplace=True, backup='.bak') as file:
    add_location_admin = False
    for line in file:
        # Set a flag if the start of the location / block is found
        if line.strip() == "location / {":
            add_location_admin = True

        # Print the current line
        print(line, end='')

        # If the closing of the location / block is found, add the location /admin block after it
        if add_location_admin and line.strip() == "}":
            print(new_location_block)
            add_location_admin = False

# After all operations are completed, restart Nginx
os.system("sudo systemctl restart nginx")
