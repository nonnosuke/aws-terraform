resource "tls_private_key" "example" {
algorithm = "RSA"
rsa_bits = 4096
}


resource "local_file" "private_key_pem" {
content = tls_private_key.example.private_key_pem
filename = "./id_rsa_finalexam"
file_permission = "0600"
}


resource "aws_key_pair" "deployer" {
key_name = var.key_name
public_key = tls_private_key.example.public_key_openssh
}
