
provider "aws" {
  region  = var.project
}

#-------------------------EC2--------------------------

# latest instances

resource "aws_instance" "Web" {
  ami                         = "ami-0279c3b3186e54acd"
  associate_public_ip_address = true
  instance_type               = var.instance-type
  key_name                    = "terraform"
  vpc_security_group_ids      = [aws_security_group.SG-Web.id]
  subnet_id                   = aws_subnet.subnet_Web.id
#  user_data                   = <<EOF
# #!/bin/bush
# sudo apt update
# sudo apt install apache2
# sudo ufw allow 'Apache'
# sudo systemctl status apache2
#    EOF

  tags = {
       Name  = "Web_server"
       owner = "Korchovyi" 
    }
}


#-------------------create VPC and Network------------------------

resource "aws_vpc" "vpc_Web" {
  cidr_block           = "10.0.0.0/16"
  tags = {
    Name = "Web_project"
  }
}


# сreate subnet in Web

resource "aws_subnet" "subnet_Web" {
  vpc_id            = aws_vpc.vpc_Web.id
  cidr_block        = "10.0.1.0/24"
}

#-------------------------create policy------------------------------

# create SG 

resource "aws_security_group" "sg-Web" {
  name        = "SG-Web-project"
  description = "Allow TCP/8080 & TCP/22 & TCP/80"
  vpc_id      = aws_vpc.vpc_Web.id
  ingress {
    description = "Allow 22 from our public IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description     = "Allow 8080 traffic from our port"
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow 80 from anywhere for redirection"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

