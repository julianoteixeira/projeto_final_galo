provider "aws" {
  region = "sa-east-1"
}
resource "aws_instance" "ec2-g4-terraform-01" {
  subnet_id     = aws_subnet.sub-g4-terraform-1a.id
  ami= "ami-0e66f5495b4efdd0f"
  instance_type = "t2.micro"
  associate_public_ip_address = true
  vpc_security_group_ids = ["${aws_security_group.sg-g4-terraform-01.id}"]
  key_name="itau-treinamento"
  root_block_device {
    encrypted = true
    volume_size = 8
  }
  tags = {
    Name = "ec2-g4-terraform-01"
  }
}
resource "aws_instance" "ec2-g4-terraform-02" {
  subnet_id     = aws_subnet.sub-g4-terraform-1c.id
  ami= "ami-0e66f5495b4efdd0f"
  instance_type = "t2.micro"
  associate_public_ip_address = true
  vpc_security_group_ids = ["${aws_security_group.sg-g4-terraform-01.id}"]
  key_name="itau-treinamento"
  root_block_device {
    encrypted = true
    volume_size = 8
  }
  tags = {
    Name = "ec2-g4-terraform-02"
  }
}
resource "aws_instance" "ec2-g4-terraform-03-private" {
  subnet_id     = aws_subnet.sub-g4-terraform-2a-private.id
  ami= "ami-0e66f5495b4efdd0f"
  instance_type = "t2.micro"
  associate_public_ip_address = false
  vpc_security_group_ids = ["${aws_security_group.sg-g4-terraform-01.id}"]
  key_name="itau-treinamento"
  root_block_device {
    encrypted = true
    volume_size = 8
  }
  tags = {
    Name = "ec2-g4-terraform-03-private"
  }
}

# https://www.terraform.io/docs/language/values/outputs.html
output "instance_private" {
  value = [
            "ssh -i ~/aws/key01 ubuntu@${aws_instance.ec2-g4-terraform-03-private.private_ip}",
            aws_instance.ec2-g4-terraform-03-private.public_ip
          ]
  description = "Mostra os IPs publicos e privados da maquina criada."
}

output "instance_puplicas" {
  value = [
            "ssh -i ~/aws/key01 ubuntu@${aws_instance.ec2-g4-terraform-01.public_ip}",
            "ssh -i ~/aws/key01 ubuntu@${aws_instance.ec2-g4-terraform-02.public_ip}"
          ]
  description = "Mostra os IPs publicos e da maquina criada."
}