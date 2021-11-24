provider "aws" {
  region = "sa-east-1"
}
resource "aws_instance" "kubernetes" {
  ami                         = var.my_ami
  instance_type               = "t2.large"
  key_name                    = var.my_key_name
  subnet_id                   = var.my_subnet_id
  associate_public_ip_address = true
  root_block_device {
    encrypted   = true
    volume_size = 8
  }
  tags = {
    Name = "ec2-kubernetes-leandsu"
  }
  vpc_security_group_ids = ["${aws_security_group.kubernetes.id}"]
}

resource "aws_security_group" "kubernetes" {
  name        = "acessos_kubernetes"
  description = "acessos_kubernetes inbound traffic"
  vpc_id      = var.my_vpc_id

  ingress = [
    {
      description      = "SSH from VPC"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids  = null,
      security_groups : null,
      self : null
    },
  ]

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"],
      prefix_list_ids  = null,
      security_groups : null,
      self : null,
      description : "Libera dados da rede interna"
    }
  ]

  tags = {
    Name = "kubernetes-lab-leandsu"
  }
}

# terraform refresh para mostrar o ssh
output "kubernetes" {
  value = [
    "kubernetes",
    "resource_id: ${aws_instance.kubernetes.id}",
    "private: ${aws_instance.kubernetes.private_ip}",
    "public: ${aws_instance.kubernetes.public_ip}",
    "public_dns: ${aws_instance.kubernetes.public_dns}",
    "ssh -i ~/.ssh/id_rsa ubuntu@${aws_instance.kubernetes.public_dns}"
  ]
}
