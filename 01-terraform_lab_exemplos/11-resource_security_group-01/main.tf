provider "aws" {
  region = "sa-east-1"
}

resource "aws_instance" "web" {

  subnet_id = "subnet-0aa28325df0a8910d"
  ami = "ami-07a33a473c28f00ed"
  instance_type = "t2.micro"
  key_name = "treinamento_itau_turma2" # Nome da Key gerada pelo ssk-keygem e upada na AWS
  associate_public_ip_address = true
  root_block_device {
    encrypted = true
    volume_size = 8
  }
  tags = {
    Name = "ec2-simple-11"
  }
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]
}
output "instance_ip_dns" {
  value = [
      aws_instance.web.public_dns,
      aws_instance.web.public_ip,
      aws_instance.web.private_ip,
      "ssh -i ~/.ssh/id_rsa ubuntu@${aws_instance.web.public_dns}"
  ]
  description = "Mostra os IPs publicos e privados da maquina criada."
}