
provider "aws" {
  region  = var.project
}

#-------------------------EC2--------------------------

# latest instances

resource "aws_instance" "Web" {
  ami                         = "ami-013dcd831e88d219f"
  associate_public_ip_address = true
  instance_type               = var.instance-type
  key_name                    = "terraform"
  vpc_security_group_ids      = [aws_security_group.sg_Web.id]
  subnet_id                   = aws_subnet.subnet_Web.id
  user_data                   = <<EOF
  #!/bin/bush
  sudo apt update
  sudo apt install apache2
  sudo ufw allow 'Apache'
  sudo systemctl status apache2
  sudo mkdir /var/www/spring-petclinic
  sudo chown -R $USER:$USER /var/www/your_domain
  sudo chmod -R 755 /var/www/spring-petclinic
    EOF

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


#create Gateway

resource "aws_internet_gateway" "web_gateway" {
  vpc_id = aws_vpc.vpc_Web.id

  tags = {
    Name = "web_gateway"
  }
}


#create RT

resource "aws_route" "web_route" {
  route_table_id         = aws_vpc.vpc_Web.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.web_gateway.id
}

#-------------------------create policy------------------------------

# create SG 

resource "aws_security_group" "sg_Web" {
  name        = "sg_Web"
  vpc_id      = aws_vpc.vpc_Web.id
  
  ingress {
    description = "Allow 22 from our public IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description  = "Allow 8080 traffic from our port"
    from_port    = 8080
    to_port      = 8080
    protocol     = "tcp"
    cidr_blocks  = ["0.0.0.0/0"]
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

  tags = {
    Name = "allow_tls"
  }
}

