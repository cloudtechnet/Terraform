provider "aws" {
  region     = "us-west-2"
  access_key = ""
  secret_key = ""
}

resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "Public-Subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.10.0/24"

  tags = {
    Name = "Public-Subnet"
  }
}