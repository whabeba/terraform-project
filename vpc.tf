
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name        = "vpc-${var.env}"
    Environment = var.env
  }
}


resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_cidr
  map_public_ip_on_launch = true

  tags = {
    Name        = "subnet-${var.env}"
    Environment = var.env
  }
}


resource "aws_s3_bucket" "my_bucket" {
  bucket = "simulated-s3-bucket-${var.env}-${random_string.suffix.result}"

  tags = {
    Environment = var.env
  }
}

resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}


resource "aws_instance" "my_ec2" {
  ami           = "ami-0c55b159cbfafe1f0" # مثال لـ AMI
  instance_type = var.instance_type
  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    Name        = "ec2-${var.env}"
    Environment = var.env
  }
}
