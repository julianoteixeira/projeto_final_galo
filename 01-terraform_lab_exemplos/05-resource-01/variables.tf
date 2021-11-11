variable "subnet_id" {
  type        = string
  description = "O valor do subnet id do para ser usado no servidor."

  validation {
    condition     = length(var.subnet_id) > 7 && substr(var.subnet_id, 0, 7) == "subnet-"
    error_message = "O valor do subnet_id não é válido, tem que começar com \"ami-\"."
  }
}
variable "image_id" {
  type        = string
  description = "O id do Amazon Machine Image (AMI) para ser usado no servidor."

  validation {
    condition     = length(var.image_id) > 4 && substr(var.image_id, 0, 4) == "ami-"
    error_message = "O valor do image_id não é válido, tem que começar com \"ami-\"."
  }
}
variable "instance_type" {
  type        = string
  description = "O tipo da instance deve ser free tier"

  validation {
    condition     = var.instance_type == "t2.micro"
    error_message = "O valor do instance_type não é válido, essa nao eh uma free tier."
  }
}