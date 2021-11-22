provider "aws" {
  region = "sa-east-1"
}

module "criar_instancia" {
  source = "./instancia"
  nome = "Um nome"
}

output "out" {
  value = [module.criar_instancia.name] 
}