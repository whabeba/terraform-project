variable "aws_region" {
  type        = string
  description = "AWS Region"
  default     = "us-east-1"
}

variable "env" {
  type        = string
  description = "Environment name (dev/stg/prod)"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for VPC"
}

variable "subnet_cidr" {
  type        = string
  description = "CIDR block for Subnet"
}

variable "instance_type" {
  type        = string
  description = "EC2 Instance Type"
}
