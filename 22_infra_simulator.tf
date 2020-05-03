locals {
  simulator_name    = "simulator"
  vpc_cidr_block    = "10.10.0.0/16"
  subnet_cidr_block = "10.10.1.0/24"
  ec2_key_name      = "simulator"
  ec2_instance_type = "t2.micro"
}
### EIP ###
resource "aws_eip" "simulator" {
  tags = merge(var.tags,
    {
      Name = format("%s-eip", local.simulator_name)
  })
}
resource "aws_eip_association" "simulator" {
  instance_id   = aws_instance.simulator.id
  allocation_id = aws_eip.simulator.id
}

### VPCs and SUBNETS ###
resource "aws_vpc" "simulator" {
  cidr_block = local.vpc_cidr_block

  tags = merge(var.tags,
    {
      Name = format("%s-vpc", local.simulator_name)
  })
}

resource "aws_subnet" "simulator" {
  vpc_id     = aws_vpc.simulator.id
  cidr_block = local.subnet_cidr_block

  tags = merge(var.tags,
    {
      Name = format("%s-public-subnet", local.simulator_name)
  })
}

### IGW ###
resource "aws_internet_gateway" "simulator" {
  vpc_id = aws_vpc.simulator.id

  tags = merge(var.tags,
    {
      Name = format("%s-igw", local.simulator_name)
  })
}

### Route tables ###
resource "aws_route_table" "simulator" {
  vpc_id = aws_vpc.simulator.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.simulator.id
  }

  tags = merge(var.tags,
    {
      Name = format("%s-rtb", local.simulator_name)
  })
}

resource "aws_route_table_association" "simulator" {
  subnet_id      = aws_subnet.simulator.id
  route_table_id = aws_route_table.simulator.id
}

### EC2 ###
data "aws_ami" "amazonlinux2" {
  most_recent = true
  owners      = ["amazon"]


  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }

}

resource "aws_instance" "simulator" {
  ami = data.aws_ami.amazonlinux2.id

  instance_type = local.ec2_instance_type
  key_name      = local.ec2_key_name

  vpc_security_group_ids = [aws_security_group.allow_home.id]
  subnet_id              = aws_subnet.simulator.id

  user_data = <<USER_DATA
		#! /bin/bash
    sudo yum update -y
    sudo yum install python3 -y
    sudo yum install python3-pip
    sudo yum install docker -y
    sudo usermod -aG docker ec2-user
    sudo service docker start
	USER_DATA

  tags = merge(var.tags,
    {
      Name = local.simulator_name
  })
}

### EC2 SG ###

resource "aws_security_group" "allow_home" {
  name        = local.simulator_name
  description = "allow access to simulator from my home"
  vpc_id      = aws_vpc.simulator.id

  ingress {
    description = "SSH from myhome"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [local.my_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags,
    {
      Name = local.simulator_name
  })
}

### Outputs ###
output "simulator_ip" {
  value = aws_eip.simulator.public_ip
}
