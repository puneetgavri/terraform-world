terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.95.0"
    }
  }
}

terraform {
  backend "s3" {
    bucket = "mytfremotebackend2304"
    key = "terraform.tfstate"
    region = "ap-northeast-1"
    encrypt = true
    use_lockfile = true
  }
}

provider "aws" {
  region = "ap-northeast-1"
}

variable "bucket_name" {
  type = string
}

variable "ami_id" {
  type = string
}

variable "i_type" {
  type = string
}

resource "aws_s3_bucket" "demo_bucket" {
  bucket = var.bucket_name
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_instance" "demo_ec2" {
  ami           = var.ami_id
  instance_type = var.i_type
  tags = {
    Name = "demo-ec2"
  }
}

output "ec2_pub_ip" {
  value = aws_instance.demo_ec2.public_ip
}

output "buck_arn" {
  value = aws_s3_bucket.demo_bucket.arn
}
