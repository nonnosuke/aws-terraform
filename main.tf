terraform {
required_version = ">= 1.2.0"
required_providers {
aws = {
source = "hashicorp/aws"
version = ">= 4.0"
}
tls = {
source = "hashicorp/tls"
}
}
}


provider "aws" {
region = var.aws_region
}


module "network" {
source = "./"
}


output "jenkins_controller_public_ip" {
value = aws_instance.jenkins_controller.public_ip
}


output "lb_dns_name" {
value = aws_lb.prod_lb.dns_name
}
