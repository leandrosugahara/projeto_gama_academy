provider "aws" {
  region = "sa-east-1"
}

# data "http" "myip" {
#   url = "http://ipv4.icanhazip.com" # outra opção "https://ifconfig.me"
# }

resource "aws_key_pair" "leandsu_ec2_dev" {
  key_name   = "leandsu_ec2_dev"
  # public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDd6OMOvF6Ds+haId5fXoLojBajtlKoFt4qp1nSPUABS2RwCaYkxjbLM2YHZbgYHrjhJzyxKduKyOJt2NMvfmlDWTwKrAiOzhKdCrkqMh8NlyoWBoh2q28Gs9yix1ffXwbUR3mSORNu71RCzgI7DYCZ4AWXYHwKJF2VYIYbl6G2acWu6XDrv5/FagG3oUvuHiPy4rHrQwLuzbgc48/xpre6tIhmPwems13tPHcFzjgSlvb3bZm/D8J60jWKKCBJqD+nO4x0PbrA1HT75DBqv3VrfGyQ9RxTuNsKRbq4vCy/uRgbFeYDuywT6ULBi90OW4XFYL6lWWNQCq1Zx52rtIELVj2UHCqUkb83ahS2mmWfIvdQBo4CoU8rpfUSYZ1O1Til/Ipo96VButmx0+bW0JVuGEn2X/xPs8LPtfZwT5X2Dn4DFAqp5d1HyKvnqA5iDZdyAwbhbwjgTbK0ve/Ev+vRn1JBSTQ3K5qL7On1IJNVfrMCqgBPa+Z04HfZhNzT3ks= ubuntu@ec2-leandsu-dev"
  public_key = var.minha_chave_dev
}

resource "aws_instance" "jenkins" {
  ami                         = "ami-0e66f5495b4efdd0f"
  instance_type               = "t2.large"
  key_name                    = "leandsu_ec2_dev"
  subnet_id                   = "subnet-037d9188710cf6ac2"
  associate_public_ip_address = true
  root_block_device {
    encrypted   = true
    volume_size = 8
  }
  tags = {
    Name = "ec2-jenkins-leandsu"
  }
  vpc_security_group_ids = ["${aws_security_group.jenkins.id}"]
}

resource "aws_security_group" "jenkins" {
  name        = "acessos_jenkins"
  description = "acessos_jenkins inbound traffic"
  vpc_id      = "vpc-0aff49d1cddbfff86"

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
    {
      description      = "SSH from VPC"
      from_port        = 8080
      to_port          = 8080
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
    Name = "jenkins-lab-leandsu"
  }
}

# terraform refresh para mostrar o ssh
output "jenkins" {
  value = [
    "jenkins",
    "id: ${aws_instance.jenkins.id}",
    "private: ${aws_instance.jenkins.private_ip}",
    "public: ${aws_instance.jenkins.public_ip}",
    "public_dns: ${aws_instance.jenkins.public_dns}",
    "ssh -i ~/.ssh/id_rsa ubuntu@${aws_instance.jenkins.public_dns}"
  ]
}
