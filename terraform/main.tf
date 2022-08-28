terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "ap-southeast-1"
}

data "aws_vpc" "default"{
  default = true
}

data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.default.id
}

resource "tls_private_key" "tls_rsa_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "app_server_ssh_key" {
  key_name   = var.ssh_key_name
  public_key = tls_private_key.tls_rsa_private_key.public_key_openssh
}

resource "aws_instance" "app_server" {
  ami           = "ami-0b89f7b3f054b957e"
  instance_type = "t2.micro"

  root_block_device {
    volume_size = 8
  }

  vpc_security_group_ids = [
    module.ec2_sg.security_group_id,
    module.dev_ssh_sg.security_group_id
  ]

  iam_instance_profile = aws_iam_instance_profile.ec2_app_server_profile.name

  key_name                = aws_key_pair.app_server_ssh_key.key_name
  monitoring              = true
  disable_api_termination = false
  ebs_optimized           = true

  tags = {
    Name = var.instance_name
    Team = var.team,
    project = "hello-world"
  }
}

resource "aws_iam_role" "ec2_app_server_role" {
  name = "ec2_app_server_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF

  tags = {
    project = "hello-world"
  }
}


resource "aws_iam_instance_profile" "ec2_app_server_profile" {
  name = "ec2_app_server_profile"
  role = aws_iam_role.ec2_app_server_role.name
}

module "dev_ssh_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "ec2_sg"
  description = "Security group for ec2_sg"
  vpc_id      = data.aws_vpc.default.id

  ingress_cidr_blocks = ["127.0.0.1/32"]
  ingress_rules       = ["ssh-tcp"]
}

module "ec2_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "ec2_sg"
  description = "Security group for ec2_sg"
  vpc_id      = data.aws_vpc.default.id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "https-443-tcp", "all-icmp"]
  egress_rules        = ["all-all"]
}

