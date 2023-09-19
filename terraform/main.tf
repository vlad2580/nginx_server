
#---------------------------------------------------#
# Made by Yurikov Vladislav 16-August-2023          #
#---------------------------------------------------#

provider "aws" {
  access_key = "AKIARB77TLWIN5K4AGSK"
  secret_key = "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"
  region     = "eu-central-1"
}


data "aws_ami" "ubuntu" {

  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}

#---------------------------------------------------#
# Creates security_group                            #
#---------------------------------------------------#

resource "aws_security_group" "webserver" {
  name = "Dinamic-Security-GrP-nginxß"

  dynamic "ingress" {
    for_each = ["80", "443", "1234"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Dynamicsss SecurityGroup"
  }
}


#---------------------------------------------------#
# Creates instance                                  #
#---------------------------------------------------#

resource "aws_instance" "nginx_instance" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name      = "vlad-key-frankfurt"
  tags = {

    Name = "ngnix_instance_1.0.0"
  }
  user_data       = file("user_data.sh")
  security_groups = [aws_security_group.webserver.name]


}



output "instance_public_ip" {
  value = aws_instance.nginx_instance.public_ip
}

#---------------------------------------------------#
# Connection check                                  #
#---------------------------------------------------#

resource "null_resource" "check_machine" {
  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Connected to the machine'",
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      host        = aws_instance.nginx_instance.public_ip
      private_key = file("vlad-key-frankfurt.pem")
    }
  }
}

#---------------------------------------------------#
# Upload Python Scripts                             #
#---------------------------------------------------#

resource "null_resource" "pyScripts" {
  provisioner "file" {
    source      = "../python"
    destination = "/home/ubuntu/scripts"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    host        = aws_instance.nginx_instance.public_ip
    private_key = file("vlad-key-frankfurt.pem")
  }
}



#---------------------------------------------------#
# Upload web files                                  #
#---------------------------------------------------#

resource "null_resource" "webApp" {
  provisioner "file" {
    source      = "../web"
    destination = "/home/ubuntu/web"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    host        = aws_instance.nginx_instance.public_ip
    private_key = file("vlad-key-frankfurt.pem")
  }
}

