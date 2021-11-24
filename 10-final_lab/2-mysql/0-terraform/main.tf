provider "aws" {
  region = "sa-east-1"
}

resource "aws_instance" "ec2_g4_myslq" {
  associate_public_ip_address = true
  subnet_id     = var.ids_subnets[count.index]
  ami           = var.my_ami
  instance_type = var.tipo_worker[count.index]
  key_name      = var.my_key_name
  root_block_device {
    encrypted = true
    volume_size = 8
  }
  count         = 3
  tags = {
    Name = "ec2_g4_mysql-${count.index}"
  }
  vpc_security_group_ids = [aws_security_group.acessos_g4_mysql.id]
}

resource "aws_security_group" "acessos_g4_mysql" {
  name        = "acessos_mysql"
  description = "acessos_mysql inbound traffic"
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
      description      = "MySQL from VPC"
      from_port        = 3306
      to_port          = 3306
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
    Name = "allow-mysql"
  }
}

output "ec2-g4-mysql" {
  value = [
    for key, item in aws_instance.ec2_g4_myslq :
      "ec2-g4-mysql ${key+1} - ${item.private_ip} - ssh -i ~/.ssh/id_rsa ubuntu@${item.public_dns} -o ServerAliveInterval=60"
  ]
}
