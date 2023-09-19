# nginx_server
# Terraform and Docker AWS Deployment

This repository contains a Terraform configuration and Docker setup for deploying a simple web server with Nginx on AWS. The deployment process includes setting up security groups, an EC2 instance, and configuring Nginx.

## Prerequisites

Before you begin, make sure you have the following installed:

- Docker
- Terraform

## Getting Started

1.Clone this repository:

```bash
git clone https://github.com/yourusername/terraform-docker-aws-deployment.git](https://github.com/vlad2580/nginx_server.git
```

2.Build the Docker container:

```bash
docker build -t terraform-container1 .
```
3.Run the Docker container:

```bash
docker run -it terraform-container1
```

# Deployment Process
## Initialization and AWS Setup

1.Terraform initializes and connects to your AWS account (for educational purposes).

2.It creates and configures a security group.

3.An EC2 instance is provisioned, and files are transferred.

## Setting Up Nginx

1.The HTTP port is changed to 1234.

2.SSL port 443 is opened.

3. SSL certificates are generated and configured.
   
## User Authentication

1.Three users (admin, Vladislav, erik) are created.

2.Passwords are hashed.

3. localhost is replaced with www.mycomp.local, and the root folder for HTML is changed.
   
## Authentication Script

1.The auth_admin.py script authenticates on https://www.mycomp.local/admin.

2.The script saves the page content to a separate file.
