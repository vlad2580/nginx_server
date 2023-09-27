# nginx_server
# Terraform and Docker AWS Deployment

This repository contains a Terraform configuration and Docker setup for deploying a simple web server with Nginx on AWS. The deployment process includes setting up security groups, an EC2 instance, and configuring Nginx.

## Prerequisites

Before you begin, make sure you have the following installed:
- Docker Engine for built&run containers
- AWS account (custom_aws_auth branch only)

### Branch custom_aws_auth update
Follow these steps to set up your AWS credentials and deploy resources:

- Docker
- AWS account



1. **Create an IAM User:**
   - Create an IAM (Identity and Access Management) user in your AWS account with permissions to create EC2 instances.

2. **Generate Access Keys:**
   - Generate an Access Key ID and Secret Access Key for the IAM user. These keys will be used to authenticate with AWS.

3. **Key Pair Assignment:**
   - Ensure that you have an existing Key Pair assigned to your EC2 instances. You can create one in the AWS EC2 console.

4. **Run the Key and Security Group Setup Script:**
   - In the cloned repository, run the following command to set up your AWS credentials:
     ```bash
     bash key_sg_setup.sh
     ```
   - Follow the prompts to enter the "Key Pair assigned at launch" (string), Serurity Group Name(string) and the direct path to your `.pem` key file.

5. **Build and Run the Container:**

   1.Build the Docker container:
   
   ```bash
   docker build -t terraform-container1 .
   ```
   2.Run the Docker container:

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
