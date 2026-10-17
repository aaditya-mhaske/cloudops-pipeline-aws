
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-2"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "aws_security_group" "devopsforge" {
  name        = "devopsforge-demo-sg"
  description = "DevOpsForge demo security group"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH - restrict to your IP before applying"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["127.0.0.1/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "devopsforge-demo-sg"
    Project = "DevOpsForge"
  }
}

resource "aws_instance" "devopsforge" {
  ami                         = data.aws_ssm_parameter.amazon_linux.value
  instance_type               = "t3.micro"
  subnet_id                   = data.aws_subnets.default.ids[0]
  vpc_security_group_ids      = [aws_security_group.devopsforge.id]
  associate_public_ip_address = true

  iam_instance_profile = "DevOpsForge-EC2-SSM-Profile"

  root_block_device {
    volume_size = 8
    volume_type = "gp3"
    encrypted   = true
  }

  tags = {
    Name    = "devopsforge-demo"
    Project = "DevOpsForge"
  }
}

data "aws_ssm_parameter" "amazon_linux" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

output "instance_id" {
  description = "DevOpsForge EC2 instance ID"
  value       = aws_instance.devopsforge.id
}

output "instance_state" {
  description = "EC2 instance state"
  value       = aws_instance.devopsforge.instance_state
}

output "public_ip" {
  description = "EC2 public IP address"
  value       = aws_instance.devopsforge.public_ip
}
