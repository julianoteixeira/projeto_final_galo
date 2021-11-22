terraform {
  required_version = ">= 0.12" # colocando compatibilidade do terraform para 0.12
}

resource "aws_instance" "web" {
  ami           = "ami-07a33a473c28f00ed"
  instance_type = "t2.micro"
  tags = {
    Name = "${var.nome}",
    Itau = true
  }
}