variable "my_vpc_id" {
  type        = string
  description = "Qual é o ID da VPC?"
  #default = "t2.micro"
}

variable "my_subnet_id" {
  type        = string
  description = "Qual é a subnet_id?"
  #default = "subnet-037d9188710cf6ac2"

  validation {
    condition     = length(var.my_subnet_id) > 7 && substr(var.my_subnet_id, 0, 7) == "subnet-"
    error_message = "O valor do subnet id não é válido!"
  }
}

variable "my_ami" {
  type        = string
  description = "Qual é o ami?"
  #default = "ami-0e66f5495b4efdd0f"

  validation {
    condition     = length(var.my_ami) > 4 && substr(var.my_ami, 0, 4) == "ami-"
    error_message = "O valor do ami não é válido!"
  }
}

variable "my_key_name" {
  type        = string
  description = "Qual é a vpc_security_group_id?"
  #default = "g4-part"
}

#variable "my_key_dev" {
#  type        = string
#  description = "Key Pair para DEV"
#}
