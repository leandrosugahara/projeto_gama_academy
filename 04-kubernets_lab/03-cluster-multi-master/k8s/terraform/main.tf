provider "aws" {
  region = "sa-east-1"
}

# data "http" "myip" {
#   url = "http://ipv4.icanhazip.com" # outra opção "https://ifconfig.me"
# }

resource "aws_key_pair" "leandsu_ec2_dev" {
    key_name = "leandsu_ec2_dev"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDd6OMOvF6Ds+haId5fXoLojBajtlKoFt4qp1nSPUABS2RwCaYkxjbLM2YHZbgYHrjhJzyxKduKyOJt2NMvfmlDWTwKrAiOzhKdCrkqMh8NlyoWBoh2q28Gs9yix1ffXwbUR3mSORNu71RCzgI7DYCZ4AWXYHwKJF2VYIYbl6G2acWu6XDrv5/FagG3oUvuHiPy4rHrQwLuzbgc48/xpre6tIhmPwems13tPHcFzjgSlvb3bZm/D8J60jWKKCBJqD+nO4x0PbrA1HT75DBqv3VrfGyQ9RxTuNsKRbq4vCy/uRgbFeYDuywT6ULBi90OW4XFYL6lWWNQCq1Zx52rtIELVj2UHCqUkb83ahS2mmWfIvdQBo4CoU8rpfUSYZ1O1Til/Ipo96VButmx0+bW0JVuGEn2X/xPs8LPtfZwT5X2Dn4DFAqp5d1HyKvnqA5iDZdyAwbhbwjgTbK0ve/Ev+vRn1JBSTQ3K5qL7On1IJNVfrMCqgBPa+Z04HfZhNzT3ks= ubuntu@ec2-leandsu-dev"
}

resource "aws_instance" "k8s_proxy" {
  ami           = "ami-0e66f5495b4efdd0f"
  instance_type = "t2.micro"
  key_name      = "leandsu_ec2_dev"
  subnet_id = "subnet-037d9188710cf6ac2"
  associate_public_ip_address = true
  root_block_device {
    encrypted = true
    volume_size = 8
  } 
  tags = {
    Name = "k8s-haproxy-leandsu"
  }
  vpc_security_group_ids = [aws_security_group.k8s_acessos_haproxy.id]
}
resource "aws_instance" "k8s_masters" {
  ami           = "ami-0e66f5495b4efdd0f"
  instance_type = var.tipo_master[count.index]
  key_name      = "leandsu_ec2_dev"
  subnet_id = var.ids_subnets[count.index]
  associate_public_ip_address = true
  root_block_device {
    encrypted = true
    volume_size = 8
  } 
  count         = 3
  tags = {
    Name = "k8s-master-${count.index}-leandsu"
  }
  vpc_security_group_ids = [aws_security_group.k8s_acessos_masters.id]
  depends_on = [
    aws_instance.k8s_workers,
  ]
}
resource "aws_instance" "k8s_workers" {
  ami           = "ami-0e66f5495b4efdd0f"
  instance_type = var.tipo_worker[count.index]
   key_name      = "leandsu_ec2_dev"
  subnet_id = var.ids_subnets[count.index]
  associate_public_ip_address = true
  root_block_device {
    encrypted = true
    volume_size = 8
  } 
  count         = 3
  tags = {
    Name = "k8s_workers-${count.index}-leandsu"
  }
  vpc_security_group_ids = [aws_security_group.k8s_acessos_workers.id]
}
resource "aws_security_group" "k8s_acessos_masters" {
  name        = "k8s_acessos_masters"
  description = "acessos inbound traffic"
  vpc_id = "vpc-0aff49d1cddbfff86"
  
  ingress = [
    {
      description      = "SSH from VPC"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids = null,
      security_groups: null,
      self: null
    },
    {
      cidr_blocks      = []
      description      = "Libera acesso k8s_masters"
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = true
      to_port          = 0
    },
    {
      cidr_blocks      = []
      description      = "Libera acesso k8s_haproxy"
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = [
        "${aws_security_group.k8s_acessos_haproxy.id}",
      ]
      self             = false
      to_port          = 0
    },
    {
      cidr_blocks      = [
        "0.0.0.0/0",
      ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 65535
    },
  ]

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = [],
      prefix_list_ids = null,
      security_groups: null,
      self: null,
      description: "Libera dados da rede interna"
    }
  ]

  tags = {
    Name = "k8s_acessos_masters_leandsu"
  }
}

resource "aws_security_group" "k8s_acessos_haproxy" {
  name        = "k8s_acessos_haproxy"
  description = "acessos inbound traffic"
  vpc_id = "vpc-0aff49d1cddbfff86"

  ingress = [
    {
      description      = "SSH from VPC"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids = null,
      security_groups: null,
      self: null
    },
    {
      cidr_blocks      = []
      description      = "Libera acesso k8s_masters"
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = [
        # "${aws_security_group.k8s_acessos_masters.id}", 
        "sg-02dcf44c0c1b8e754" # master
      ]
      self             = false
      to_port          = 0
    },
    {
      cidr_blocks      = []
      description      = "Libera acesso k8s_workers"
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = [
        # "${aws_security_group.k8s_acessos_masters.id}", 
        "sg-0cd733d76cf3ae4c7"  # worker
      ]
      self             = false
      to_port          = 0
    },
    {
      cidr_blocks      = []
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = true
      to_port          = 65535
    },
  ]

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = [],
      prefix_list_ids = null,
      security_groups: null,
      self: null,
      description: "Libera dados da rede interna"
    }
  ]

  tags = {
    Name = "k8s_acessos_haproxy_leandsu"
  }
}
resource "aws_security_group" "k8s_acessos_workers" {
  name        = "k8s_acessos_workers"
  description = "acessos inbound traffic"
  vpc_id = "vpc-0aff49d1cddbfff86"

  ingress = [
    {
      description      = "SSH from VPC"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids = null,
      security_groups: null,
      self: null
    },
    {
      cidr_blocks      = []
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = [
        "${aws_security_group.k8s_acessos_masters.id}",
      ]
      self             = false
      to_port          = 0
    },
    {
      cidr_blocks      = []
      description      = "Libera acesso k8s_haproxy"
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = [
        "${aws_security_group.k8s_acessos_haproxy.id}",
      ]
      self             = true
      to_port          = 0
    },
    {
      cidr_blocks      = []
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = true
      to_port          = 65535
    },
    {
      description      = "Liberando app para o mundo!"
      from_port        = 30000
      to_port          = 30000
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
      prefix_list_ids = null,
      security_groups: null,
      self: null
    },       
  ]

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = [],
      prefix_list_ids = null,
      security_groups: null,
      self: null,
      description: "Libera dados da rede interna"
    }
  ]

  tags = {
    Name = "k8s_acessos_workers_leandsu"
  }
}

output "k8s-masters" {
  value = [
    for key, item in aws_instance.k8s_masters :
      "k8s-master ${key+1} - ${item.private_ip} - ssh -i ~/.ssh/id_rsa ubuntu@${item.public_dns} -o ServerAliveInterval=60"
  ]
}

output "output-k8s_workers" {
  value = [
    for key, item in aws_instance.k8s_workers :
      "k8s-workers ${key+1} - ${item.private_ip} - ssh -i ~/.ssh/id_rsa ubuntu@${item.public_dns} -o ServerAliveInterval=60"
  ]
}

output "output-k8s_proxy" {
  value = [
    "k8s_proxy - ${aws_instance.k8s_proxy.private_ip} - ssh -i ~/.ssh/id_rsa ubuntu@${aws_instance.k8s_proxy.public_dns} -o ServerAliveInterval=60"
  ]
}

output "sg_masters" {
  value = "sg dos masters - ${aws_security_group.k8s_acessos_masters.id}"
}

output "sg-haproxy" {
  value = "sg do haproxy - ${aws_security_group.k8s_acessos_haproxy.id}"
}

output "sg_workers" {
  value = "sg dos workers - ${aws_security_group.k8s_acessos_workers.id}"
}



# terraform refresh para mostrar o ssh
