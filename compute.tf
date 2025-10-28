# Jenkins controller


tags = { Name = "JenkinsController" }


user_data = file("user_data/jenkins_setup.sh")
}


# Permanent agent
resource "aws_instance" "jenkins_permanent_agent" {
ami = var.app_ami
instance_type = var.instance_type
key_name = aws_key_pair.deployer.key_name
subnet_id = aws_subnet.public.id
associate_public_ip_address = true
security_groups = [aws_security_group.ssh_http.id]
tags = { Name = "JenkinsPermanentAgent" }
}


# Dynamic agent (will run agent launcher / java agent)
resource "aws_instance" "jenkins_dynamic_agent" {
ami = var.app_ami
instance_type = var.instance_type
key_name = aws_key_pair.deployer.key_name
subnet_id = aws_subnet.public.id
associate_public_ip_address = true
security_groups = [aws_security_group.ssh_http.id]
tags = { Name = "JenkinsDynamicAgent" }
}


# Testing, Staging, Prod instances
resource "aws_instance" "testing" {
ami = var.app_ami
instance_type = var.instance_type
key_name = aws_key_pair.deployer.key_name
subnet_id = aws_subnet.public.id
associate_public_ip_address = true
security_groups = [aws_security_group.ssh_http.id]
tags = { Name = "Testing_Env" }
user_data = file("scripts/deploy_app.sh")
}


resource "aws_instance" "staging" {
ami = var.app_ami
instance_type = var.instance_type
key_name = aws_key_pair.deployer.key_name
subnet_id = aws_subnet.public.id
associate_public_ip_address = true
security_groups = [aws_security_group.ssh_http.id]
tags = { Name = "Staging_Env" }
user_data = file("scripts/deploy_app.sh")
}


resource "aws_instance" "production1" {
ami = var.app_ami
instance_type = var.instance_type
key_name = aws_key_pair.deployer.key_name
subnet_id = aws_subnet.public.id
associate_public_ip_address = true
security_groups = [aws_security_group.ssh_http.id]
tags = { Name = "Production_Env1" }
user_data = file("scripts/deploy_app.sh")
}


resource "aws_instance" "production2" {
ami = var.app_ami
instance_type = var.instance_type
key_name = aws_key_pair.deployer.key_name
subnet_id = aws_subnet.public.id
associate_public_ip_address = true
security_groups = [aws_security_group.ssh_http.id]
tags = { Name = "Production_Env2" }
user_data = file("scripts/deploy_app.sh")
}
