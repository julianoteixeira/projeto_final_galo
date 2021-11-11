provider "aws" {
  region = "sa-east-1"
}
resource "aws_instance" "web" {
  count = 2
  subnet_id = var.subnet_id
  ami= var.image_id
  instance_type = var.instance_type
  key_name = "treinamento_itau_turma2"
  associate_public_ip_address = true
  root_block_device {
    encrypted = true
    volume_size = 8
  }
  tags = {
    Name = "ec2-${(count.index+1)}-tf"
  }
}

output "instance_ip_dns" {
  value = [
    for key, item in aws_instance.web:
      "public_dns = ${item.public_dns} ; public_ip = ${item.public_ip} ; private_ip = ${item.private_ip}"
  ]
  description = "Mostra os IPs publicos e privados da maquina criada."
}