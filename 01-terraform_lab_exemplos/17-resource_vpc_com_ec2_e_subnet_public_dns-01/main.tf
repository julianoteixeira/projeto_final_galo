provider "aws" {
  region = "sa-east-1"
}

resource "aws_instance" "web" {
  count = 3
  ami                     = data.aws_ami.ubuntu.id
  instance_type           = "t2.micro"
  key_name                = "treinamento_itau_turma2" # key chave publica cadastrada na AWS 
  subnet_id               =  aws_subnet.my_subnet[count.index].id # vincula a subnet direto e gera o IP automático
  private_ip              = "172.17.0.100"
  vpc_security_group_ids  = [
    "${aws_security_group.allow_ssh_terraform.id}",
  ]

  tags = {
    Name = "ec2-${(count.index+1)}-tf"
  }
}

resource "aws_eip" "example" {
  vpc = true
}

resource "aws_eip_association" "eip_assoc" {
  count = 3
  instance_id   = aws_instance.web[count.index].id
  allocation_id = aws_eip.example.id
}

# terraform refresh para mostrar o ssh

#output "aws_instance_e_ssh" {
#  value = [
#    aws_instance.web[count.index].public_ip,
#    "ssh -i ~/.ssh/id_rsa ubuntu@${aws_instance.web[count.index].public_dns}"
#  ]
#}