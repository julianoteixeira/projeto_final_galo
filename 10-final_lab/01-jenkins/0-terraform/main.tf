provider "aws" {
  region = "sa-east-1"
}

#resource "aws_key_pair" "g4_ec2_dev" {
#  key_name   = var.my_key_name
#  public_key = var.my_key_dev
#}

resource "aws_instance" "jenkins" {
  ami                         = var.my_ami
  instance_type               = "t2.2xlarge"
  key_name                    = var.my_key_name
  subnet_id                   = var.my_subnet_id
  associate_public_ip_address = true
  root_block_device {
    encrypted   = true
    volume_size = 8
  }
  tags = {
    Name = "ec2-jenkins-g4"
  }
  vpc_security_group_ids = ["${aws_security_group.jenkins.id}"]
}

resource "aws_security_group" "jenkins" {
  name        = "acessos_jenkins"
  description = "acessos_jenkins inbound traffic"
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
      from_port        = 8080
      to_port          = 8080
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
    Name = "jenkins-lab-g4"
  }
}

# terraform refresh para mostrar o ssh
output "jenkins" {
  value = [
    "resource_id: ${aws_instance.jenkins.id}",
    "public_ip: ${aws_instance.jenkins.public_ip}",
    "public_dns: ${aws_instance.jenkins.public_dns}",
    "ssh -i /var/lib/jenkins/.ssh/id_rsa ubuntu@${aws_instance.jenkins.public_dns}"
  ]
}
