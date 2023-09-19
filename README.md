# nginx_server
# Terraform and Docker AWS Deployment

This repository contains a Terraform configuration and Docker setup for deploying a simple web server with Nginx on AWS. The deployment process includes setting up security groups, an EC2 instance, and configuring Nginx.

## Prerequisites

Before you begin, make sure you have the following installed:

- Docker
- Terraform
- AWS CLI configured with your AWS credentials

## Getting Started

1. Clone this repository:

   ```bash
   git clone https://github.com/yourusername/terraform-docker-aws-deployment.git
   cd terraform-docker-aws-deployment
Build the Docker container:

  ```bash
   docker build -t terraform-container1 .

Run the Docker container:

bash
docker run -it terraform-container1
Deployment Process
Initialization and AWS Setup:

Terraform initializes and connects to your AWS account (for educational purposes).
It creates and configures a security group.
An EC2 instance is provisioned, and files are transferred.
Setting Up Nginx:

The HTTP port is changed to 1234.
SSL port 443 is opened.
SSL certificates are generated and configured.
User Authentication:

Three users (admin, Vladislav, erik) are created.
Passwords are hashed.
localhost is replaced with www.mycomp.local, and the root folder for HTML is changed.
Authentication Script:

The auth_admin.py script authenticates on https://www.mycomp.local/admin.
The script saves the page content to a separate file.
Usage
After the deployment process is complete, you can access the web server by navigating to https://www.mycomp.local/admin. The auth_admin.py script provides an example of how to authenticate and retrieve the page content.

Feel free to modify the Terraform configuration and Docker setup to suit your specific needs
