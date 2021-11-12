terraform {
  backend "remote" {
    organization = "leandsu"

    workspaces {
      name = "projeto-gama-academy"
    }
  }
}