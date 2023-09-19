import os
import requests
from requests.auth import HTTPBasicAuth

# Define the URL and credentials
url = "https://www.mycomp.local/admin"
username = "admin"
password = "PC7HAmDF"  # Replace with the actual password

# Define the directory and file path for the output
output_directory = "/home/ubuntu/auth_output"
output_file_path = os.path.join(output_directory, "result.txt")

# Make sure the output directory exists, create it if not
os.makedirs(output_directory, exist_ok=True)

# Make the request with basic authentication and SSL certificate verification disabled
response = requests.get(url, auth=HTTPBasicAuth(username, password), verify=False)

# Check the response status code
if response.status_code == 200:
    print("Login successful.")
    
    # Write the response content to the output file
    with open(output_file_path, "w") as output_file:
        output_file.write(response.text)
        
    print(f"Output saved to: {output_file_path}")
else:
    print(f"Login failed with status code: {response.status_code}")

# После выполнения всех операций, перезапускаем Nginx
os.system("sudo systemctl restart nginx")