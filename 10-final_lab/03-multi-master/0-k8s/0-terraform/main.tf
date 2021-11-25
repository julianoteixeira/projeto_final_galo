provider "aws" {
  region = "sa-east-1"
}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com" # outra opção "https://ifconfig.me"
}

resource "aws_instance" "k8s_g4_proxy" {
  associate_public_ip_address = true
  subnet_id = var.my_subnet_id
  ami           = var.my_ami
  instance_type = "t2.medium"
  key_name      = var.my_key_name
  root_block_device {
    encrypted = true
    volume_size = 8
  }
  tags = {
    Name = "k8s-g4-haproxy"
  }
  vpc_security_group_ids = [aws_security_group.acessos_g4_haproxy.id]
}

resource "aws_instance" "k8s_g4_masters" {
  associate_public_ip_address = true
  subnet_id = var.my_subnet_id
  ami           = var.my_ami
  instance_type = "t2.large"
  key_name      = var.my_key_name
  root_block_device {
    encrypted = true
    volume_size = 8
  }
  count         = 3
  tags = {
    Name = "k8s-g4-master-${count.index}"
  }
  vpc_security_group_ids = [aws_security_group.acessos_g4_masters.id]
  depends_on = [
    aws_instance.k8s_g4_workers,
  ]
}

resource "aws_instance" "k8s_g4_workers" {
  associate_public_ip_address = true
  subnet_id = var.my_subnet_id
  ami           = var.my_ami
  instance_type = "t2.medium"
  key_name      = var.my_key_name
  root_block_device {
    encrypted = true
    volume_size = 8
  }
  count         = 3
  tags = {
    Name = "k8s_g4_workers-${count.index}"
  }
  vpc_security_group_ids = [aws_security_group.acessos_g4_workers.id]
}


resource "aws_security_group" "acessos_g4_masters" {
  name        = "k8s-g4-acessos_masters"
  description = "acessos inbound traffic"
  vpc_id =  var.my_vpc_id

  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_security_group" "acessos_g4_master_main" {
  name        = "k8s-g4-acessos_g4_master_main"
  description = "acessos inbound traffic"
  vpc_id =  var.my_vpc_id

  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_security_group" "acessos_g4_haproxy" {
  name        = "k8s-g4-haproxy"
  description = "acessos inbound traffic"
  vpc_id =  var.my_vpc_id

  tags = {
    Name = "allow_haproxy_ssh"
  }
}

resource "aws_security_group" "acessos_g4_workers" {
  name        = "k8s-g4-workers"
  description = "acessos inbound traffic"
  vpc_id =  var.my_vpc_id

  tags = {
    Name = "allow_ssh"
  }
}

output "k8s-g4-masters" {
  value = [
    for key, item in aws_instance.k8s_g4_masters :
      "k8s-g4-master ${key+1} - ${item.private_ip} - ssh -i ~/.ssh/id_rsa ubuntu@${item.public_dns} -o ServerAliveInterval=60"
  ]
}

output "output-k8s_g4_workers" {
  value = [
    for key, item in aws_instance.k8s_g4_workers :
      "k8s-g4-workers ${key+1} - ${item.private_ip} - ssh -i ~/.ssh/id_rsa ubuntu@${item.public_dns} -o ServerAliveInterval=60"
  ]
}

output "output-k8s_g4_proxy" {
  value = [
    "k8s_g4_proxy - ${aws_instance.k8s_g4_proxy.private_ip} - ssh -i ~/.ssh/id_rsa ubuntu@${aws_instance.k8s_g4_proxy.public_dns} -o ServerAliveInterval=60"
  ]
}

output "security-group-workers-e-haproxy" {
  value = aws_security_group.acessos_g4_haproxy.id
}



# terraform refresh para mostrar o ssh
