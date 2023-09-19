import fileinput
import os

nginx_config_file = "/etc/nginx/sites-available/default"

# Пути к сертификату и ключу SSL
certificate_path = "/etc/nginx/ssl/www.mycomp.local+4.pem"
private_key_path = "/etc/nginx/ssl/www.mycomp.local+4-key.pem"

# Читаем файл конфигурации и создаем временный файл
with fileinput.input(nginx_config_file, inplace=True, backup='.bak') as file:
    add_ssl_paths = False
    for line in file:
        # Если строка содержит "listen [::]:443 ssl default_server;"
        if line.strip() == "# listen [::]:443 ssl default_server;" or \
           line.strip() == "listen [::]:443 ssl default_server;":
            add_ssl_paths = True

        # Печатаем текущую строку
        print(line, end='')

        # Если найдена строка с SSL-конфигурацией, добавляем пути к сертификату и ключу
        if add_ssl_paths:
            print(f"        ssl_certificate {certificate_path};")
            print(f"        ssl_certificate_key {private_key_path};")
            add_ssl_paths = False

            
# После выполнения всех операций, перезапускаем Nginx
os.system("sudo systemctl restart nginx")