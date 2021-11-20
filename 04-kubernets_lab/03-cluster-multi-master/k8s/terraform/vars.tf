variable "ip_haproxy" {
  type = string
  default = "187.3.223.136"
  description = "Passe aqui o IP do haproxy"
}

variable "ids_subnets" {
  type        = list(string)
  default     = [
    "subnet-037d9188710cf6ac2",
    "subnet-0bb9a1894421c8d22",
    "subnet-0e9e0ad7b155646eb"
  ]
}

variable "tipo_master" {
  type        = list(string)
  default     = [
    "t2.large",
    "t3.large",
    "t2.large"
  ]
}

variable "tipo_worker" {
  type        = list(string)
  default     = [
    "t2.medium",
    "t3.medium",
    "t2.medium"
  ]
}