terraform {
  backend "remote" {
    organization = "guilhermeagb"

    workspaces {
      name = "treinamento-devops"
    }
  }
}