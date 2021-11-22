provider "aws" {
  region = "sa-east-1"
}
resource "aws_instance" "web" {
  subnet_id     = "subnet-0aa28325df0a8910d"
  ami= "ami-07a33a473c28f00ed"
  instance_type = "t2.micro"
  associate_public_ip_address = true
  vpc_security_group_ids = ["sg-05ebbe57543a1d0f9"]
  key_name="treinamento_itau_turma2"
  root_block_device {
    encrypted = true
    volume_size = 8
  }
  tags = {
    Name = "${var.nome}"
  }
}