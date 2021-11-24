provider "aws" {
  region = "sa-east-1"
}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com" # outra opção "https://ifconfig.me"
}

resource "aws_instance" "dev_deploy_g4" {
  ami           = var.my_ami
  instance_type = "t2.medium"

  for_each = toset(["dev", "stage", "prod"])

  key_name      = var.my_key_name
  tags = {
    Name = "dev_deploy_g4_${each.key}"
  }
  vpc_security_group_ids = [aws_security_group.acesso_g4_dev.id]
}

resource "aws_security_group" "acesso_g4_dev" {
  name        = "acesso_g4_dev"
  description = "acesso_g4_dev inbound traffic"

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
    Name = "g4-dev-img-lab"
  }
}

output "dev_deploy_g4" {
  value = [
    for key, item in aws_instance.dev_deploy_g4 :
      "public_ip-${key}: ${item.public_ip}"
  ]
}