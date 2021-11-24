variable "ip_haproxy" {
  type = string
  default = "187.3.223.136"
  description = "Passe aqui o IP do haproxy"
}
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


variable "sg_front_object" {
  description = "Security group data for Frontend in Kubernetes environment."
  type = object({
      name = string
      description = string
  })
}

variable "sg_hproxy_object" {
  description = "Security group data for HPROXY in Kubernetes environment."
  type = object({
      name = string
      description = string
  })
}

variable "sg_master_object" {
  description = "Security group data for Master nodes in Kubernetes environment."
  type = object({
      name = string
      description = string
  })
}

variable "sg_worker_object" {
  description = "Security group data for Worker nodes in Kubernetes environment."
  type = object({
      name = string
      description = string
  })
}

variable "instance_k8s_front_object" {
  description = "Instance template data for Frontend in Kubernetes environment."
  type = object({
      name = string
      type = string
      key_pair = string
      iam_profile = string
      number_of_nodes = number
      public_ip = bool
  })
}

variable "instance_k8s_hproxy_object" {
  description = "Instance template data for HPROXY in Kubernetes environment."
  type = object({
      name = string
      type = string
      key_pair = string
      iam_profile = string
      number_of_nodes = number
      public_ip = bool
  })
}

variable "instance_k8s_master_object" {
  description = "Instance template data for Master nodes in Kubernetes environment."
  type = object({
      name = string
      type = string
      key_pair = string
      iam_profile = string
      number_of_nodes = number
      public_ip = bool
  })
}

variable "instance_k8s_worker_object" {
  description = "Instance template data for Worker nodes in Kubernetes environment."
  type = object({
      name = string
      type = string
      key_pair = string
      iam_profile = string
      number_of_nodes = number
      public_ip = bool
  })
}