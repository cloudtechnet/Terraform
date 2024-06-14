provider "aws" {
  region     = var.region
  access_key = ""
  secret_key = ""
}


#create vpc 
resource "aws_vpc" "VPC01" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  
  tags = {
    Name = "VPC01"
  }
}

#create subnet01
 resource "aws_subnet" "subnet01" {
   vpc_id     = aws_vpc.VPC01.id
   cidr_block = "10.0.10.0/24"
   availability_zone = "us-west-2a"
   tags = {
     Name = "subnet01"
   }
}

#create subnet01
resource "aws_subnet" "subnet02" {
   vpc_id     = aws_vpc.VPC01.id
   cidr_block = "10.0.20.0/24"
   availability_zone = "us-west-2b"
   tags = {
     Name = "subnet02"
   }
}

#create internet gateway
resource "aws_internet_gateway" "IGW_VPC01" {
  vpc_id = aws_vpc.VPC01.id
  
  tags = {
    Name = "IGW_VPC01"
  }
}

#create route table

resource "aws_route_table" "RT-VPC01" {
  vpc_id = aws_vpc.VPC01.id
  
  tags = {
    Name = "RT-VPC01"
  }
}

#create route to internet gateway
resource "aws_route" "internet_route" {
  route_table_id = aws_route_table.RT-VPC01.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.IGW_VPC01.id
}

#associate route table with subnet01
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.subnet01.id
  route_table_id = aws_route_table.RT-VPC01.id
}

#associate route table with subnet02
resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.subnet02.id
  route_table_id = aws_route_table.RT-VPC01.id
}

#create security group

resource "aws_security_group" "allow_ssh" {
  description = "allow ssh inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.VPC01.id
  
  tags = {
     Name = "allow_ssh"
  }
}

#allow port numbers 

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
   security_group_id = aws_security_group.allow_ssh.id
   cidr_ipv4         = aws_vpc.VPC01.cidr_block
   from_port         = 22
   ip_protocol          = "tcp"
   to_port           = 22
}
  
#create subnet01 instance in subnet01 network

resource "aws_instance" "my_instance" {
   ami = "ami-0b20a6f09484773af"
   instance_type = "t2.micro"
   subnet_id = aws_subnet.subnet01.id
   vpc_security_group_ids = [aws_security_group.allow_ssh.id]
   
   tags = {
     Name = "subnet01-VM"
  }
}

#create subnet02 instance in subnet02 network

resource "aws_instance" "my_instance2" {
   ami = "ami-0b20a6f09484773af"
   instance_type = "t2.micro"
   subnet_id = aws_subnet.subnet02.id
   vpc_security_group_ids = [aws_security_group.allow_ssh.id]
   
   tags = {
     Name = "subnet02-VM"
  }
}   
   




