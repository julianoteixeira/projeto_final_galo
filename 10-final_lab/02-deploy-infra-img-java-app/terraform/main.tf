provider "aws" {
  region = "sa-east-1"
}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com" # outra opção "https://ifconfig.me"
}

resource "aws_instance" "dev_img_deploy" {
  associate_public_ip_address = true
  ami                         = var.my_ami
  subnet_id                   = var.my_subnet_id
  instance_type = "t2.medium"
  key_name      = var.my_key_name
  tags = {
    Name = "dev_img_deploy"
  }
  vpc_security_group_ids = [aws_security_group.acesso_dev_img.id]
}

resource "aws_security_group" "acesso_dev_img" {
  name        = "acesso_dev_img"
  description = "acesso_dev_img inbound traffic"
  vpc_id      = var.my_vpc_id
  
  ingress = [
    {
      description      = "SSH from VPC"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = null,
      security_groups : null,
      self : null
    },
    {
      description      = "SSH from VPC"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = null,
      security_groups : null,
      self : null
    },
  ]

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"],
      prefix_list_ids  = null,
      security_groups : null,
      self : null,
      description : "Libera dados da rede interna"
    }
  ]

  tags = {
    Name = "dev-img-lab"
  }
}

# terraform refresh para mostrar o ssh
output "dev_img_deploy" {
  value = [
    "resource_id: ${aws_instance.dev_img_deploy.id}",
    "public_ip: ${aws_instance.dev_img_deploy.public_ip}",
    "public_dns: ${aws_instance.dev_img_deploy.public_dns}",
    "ssh -i /var/lib/jenkins/.ssh/id_rsa ubuntu@${aws_instance.dev_img_deploy.public_dns}"
  ]
}
