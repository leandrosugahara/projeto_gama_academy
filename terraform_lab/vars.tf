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

variable "my_instance_type" {
  type        = string
  description = "Qual é o instance_type?"
  #default = "t2.micro"

  validation {
    condition     = substr(var.my_instance_type, 0, 3) == "t2."
    error_message = "O valor do intance type não é válido!"
  }
}

variable "my_vpc_security_group_ids" {
  type        = string
  description = "Qual é a vpc_security_group_id?"
  #default = ["sg-05fb5f608a43df40f"]

  validation {
    condition     = substr(var.my_vpc_security_group_ids, 0, 3) == "sg-"
    error_message = "O valor do vpc security group id não é válido!"
  }
}

variable "my_key_name" {
  type        = string
  description = "Qual é a vpc_security_group_id?"
  #default = "leandsu-part"
}