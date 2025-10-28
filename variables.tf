variable "aws_region" {
type = string
default = "us-east-1" # change as needed
}


variable "key_name" {
type = string
default = "finalexam-key"
}


variable "instance_type" {
type = string
default = "t3.micro"
}


variable "jenkins_ami" {
type = string
description = "AMI for Jenkins controller (Ubuntu 22.04 or Amazon Linux 2)
"
default = "ami-0abcdef1234567890" # <-- replace with real AMI
}


variable "app_ami" {
type = string
default = "ami-0abcdef1234567890"
}


variable "vpc_cidr" {
type = string
default = "10.0.0.0/16"
}
