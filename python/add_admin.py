import fileinput
import os


nginx_config_file = "/etc/nginx/sites-available/default"

# Создаем строку для добавления location /admin
new_location_block = """
        location /admin {
                auth_basic "Restricted Access";
                auth_basic_user_file /etc/nginx/.htpasswd;
                alias /home/ubuntu/web;
                index admin.html;
        }
"""

# Читаем файл конфигурации и создаем временный файл
with fileinput.input(nginx_config_file, inplace=True, backup='.bak') as file:
    add_location_admin = False
    for line in file:
        # Если найдено начало блока location /, устанавливаем флаг
        if line.strip() == "location / {":
            add_location_admin = True

        # Печатаем текущую строку
        print(line, end='')

        # Если найдено закрытие блока location /, добавляем location /admin после него
        if add_location_admin and line.strip() == "}":
            print(new_location_block)
            add_location_admin = False

# После выполнения всех операций, перезапускаем Nginx
os.system("sudo systemctl restart nginx")
