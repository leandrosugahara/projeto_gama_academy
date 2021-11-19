
variable "nome_ec2_private" {
  type = string
  description = "Digite o nome da instancia"
}

variable vpc_id_modulo {
  type = string
  description = "Id da VPC"
}

variable ami_modulo {
  type = string
  description = "Id da AMI"
}

variable vpc_security_group_ids_modulo {
  type = string
  description = "Id do SG"
}
