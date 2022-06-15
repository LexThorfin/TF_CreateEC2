##Also, the original didn't use local/locals. Adding that in here just
##for repetition and learning. Doesn't really save much in this case
locals {
    region = "us-west-2"
    profile = "maslow"
    tags = { 
        Owner       = "ForEssent"
        Environment = "dev"
        Name = "HelloWorld"
    }
}

##This code is not required for aws provider - but including it here
##to keep the idea in my mind
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.18"
    }
  }
}

##this is for the most part straight from the Terraform Documentation

provider "aws" {
  region = local.region
  profile = local.profile
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

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

  tags = local.tags
}