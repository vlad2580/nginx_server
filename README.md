# nginx_server
# Terraform and Docker AWS Deployment

This repository contains a Terraform configuration and Docker setup for deploying a simple web server with Nginx on AWS. The deployment process includes setting up security groups, an EC2 instance, and configuring Nginx.

## Prerequisites

Before you begin, make sure you have the following installed:

- Docker
- Terraform
- AWS CLI configured with your AWS credentials

## Getting Started

1.Clone this repository:

```bash
git clone https://github.com/yourusername/terraform-docker-aws-deployment.git
cd terraform-docker-aws-deployment
```

2.Build the Docker container:

```bash
docker build -t terraform-container1 .
```
3.Run the Docker container:

```bash
docker run -it terraform-container1
```
