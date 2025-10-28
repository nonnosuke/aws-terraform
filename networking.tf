resource "aws_vpc" "main" {
cidr_block = var.vpc_cidr
tags = { Name = "finalexam-vpc" }
}


resource "aws_subnet" "public" {
vpc_id = aws_vpc.main.id
cidr_block = "10.0.1.0/24"
map_public_ip_on_launch = true
availability_zone = "${var.aws_region}a"
tags = { Name = "public-subnet" }
}


resource "aws_internet_gateway" "igw" {
vpc_id = aws_vpc.main.id
}


resource "aws_route_table" "public" {
vpc_id = aws_vpc.main.id
route {
cidr_block = "0.0.0.0/0"
gateway_id = aws_internet_gateway.igw.id
}
}


resource "aws_route_table_association" "a" {
subnet_id = aws_subnet.public.id
route_table_id = aws_route_table.public.id
}


resource "aws_security_group" "ssh_http" {
name = "ssh-http-sg"
vpc_id = aws_vpc.main.id


ingress {
description = "SSH"
from_port = 22
to_port = 22
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}


ingress {
description = "HTTP"
from_port = 80
to_port = 80
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}


ingress {
description = "Jenkins (8080)"
from_port = 8080
to_port = 8080
protocol = "tcp"
cidr_blocks = ["0.0.0.0/0"]
}


egress {
from_port = 0
to_port = 0
protocol = "-1"
cidr_blocks = ["0.0.0.0/0"]
}
}
