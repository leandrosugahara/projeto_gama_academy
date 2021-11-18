provider "aws" {
 region = "sa-east-1"
}

# data "http" "myip" {
#   url = "http://ipv4.icanhazip.com" # outra opção "https://ifconfig.me"
# }

resource "aws_instance" "maquina_master" {
  ami           = "ami-0e66f5495b4efdd0f"
  instance_type = "t2.large"
  key_name      = "leandsu_ec2_dev"
  subnet_id = "subnet-037d9188710cf6ac2"
  associate_public_ip_address = true
  root_block_device {
    encrypted = true
    volume_size = 8
  }  
  tags = {
    Name = "k8s-master-leandsu"
  }
  vpc_security_group_ids = [aws_security_group.acessos_master_single_master.id]
  depends_on = [
    aws_instance.worker1, aws_instance.worker2, aws_instance.worker3
  ]
}

resource "aws_key_pair" "leandsu_ec2_dev" {
    key_name = "leandsu_ec2_dev"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDd6OMOvF6Ds+haId5fXoLojBajtlKoFt4qp1nSPUABS2RwCaYkxjbLM2YHZbgYHrjhJzyxKduKyOJt2NMvfmlDWTwKrAiOzhKdCrkqMh8NlyoWBoh2q28Gs9yix1ffXwbUR3mSORNu71RCzgI7DYCZ4AWXYHwKJF2VYIYbl6G2acWu6XDrv5/FagG3oUvuHiPy4rHrQwLuzbgc48/xpre6tIhmPwems13tPHcFzjgSlvb3bZm/D8J60jWKKCBJqD+nO4x0PbrA1HT75DBqv3VrfGyQ9RxTuNsKRbq4vCy/uRgbFeYDuywT6ULBi90OW4XFYL6lWWNQCq1Zx52rtIELVj2UHCqUkb83ahS2mmWfIvdQBo4CoU8rpfUSYZ1O1Til/Ipo96VButmx0+bW0JVuGEn2X/xPs8LPtfZwT5X2Dn4DFAqp5d1HyKvnqA5iDZdyAwbhbwjgTbK0ve/Ev+vRn1JBSTQ3K5qL7On1IJNVfrMCqgBPa+Z04HfZhNzT3ks= ubuntu@ec2-leandsu-dev"
}

resource "aws_instance" "worker1" {
  ami           = "ami-0e66f5495b4efdd0f"
  instance_type = "t2.medium"
  key_name      =  "leandsu_ec2_dev"
  subnet_id = "subnet-037d9188710cf6ac2"
  associate_public_ip_address = true
  root_block_device {
    encrypted = true
    volume_size = 8
  } 
  tags = {
    # Name = "k8s-node-${count.index+1}"
    Name = "k8s-node-1-leandsu"
  }
  vpc_security_group_ids = [aws_security_group.acessos_workers_single_master.id]
  # count         = 3
}

resource "aws_instance" "worker2" {
  ami           = "ami-0e66f5495b4efdd0f"
  instance_type = "t3.nano"
  key_name      =  "leandsu_ec2_dev"
  subnet_id = "subnet-0bb9a1894421c8d22"
  associate_public_ip_address = true
  root_block_device {
    encrypted = true
    volume_size = 8
  } 
  tags = {
    # Name = "k8s-node-${count.index+1}"
    Name = "k8s-node-2-leandsu"
  }
  vpc_security_group_ids = [aws_security_group.acessos_workers_single_master.id]
  # count         = 3
}

resource "aws_instance" "worker3" {
  ami           = "ami-0e66f5495b4efdd0f"
  instance_type = "t2.medium"
  key_name      =  "leandsu_ec2_dev"
  subnet_id = "subnet-0e9e0ad7b155646eb"
  associate_public_ip_address = true
  root_block_device {
    encrypted = true
    volume_size = 8
  } 
  tags = {
    # Name = "k8s-node-${count.index+1}"
    Name = "k8s-node-3-leandsu"
  }
  vpc_security_group_ids = [aws_security_group.acessos_workers_single_master.id]
  # count         = 3
}
resource "aws_security_group" "acessos_master_single_master" {
  name        = "acessos_master_single_master"
  description = "acessos_master_single_master inbound traffic"
  vpc_id = "vpc-0aff49d1cddbfff86"
  
  ingress = [
    {
      description      = "SSH from VPC"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
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
        "sg-02a36b2c1056b28f2", # circular, depende da criacao do sg dos workers que depende do sg do master
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
    {
      description      = "Liberando app nodejs para o mundo!"
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
      ipv6_cidr_blocks = ["::/0"],
      prefix_list_ids = null,
      security_groups: null,
      self: null,
      description: "Libera dados da rede interna"
    }
  ]

  tags = {
    Name = "acessos_master_single_master_leandsu"
  }
}


resource "aws_security_group" "acessos_workers_single_master" {
  name        = "acessos_workers_single_master"
  description = "acessos_workers_single_master inbound traffic"
  vpc_id = "vpc-0aff49d1cddbfff86"
  
  ingress = [
    {
      description      = "SSH from VPC"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
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
        "${aws_security_group.acessos_master_single_master.id}",
      ]
      self             = false
      to_port          = 0
    },
  ]

  egress = [
    {
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"],
      prefix_list_ids = null,
      security_groups: null,
      self: null,
      description: "Libera dados da rede interna"
    }
  ]

  tags = {
    Name = "acessos_workers_single_master_leandsu"
  }
}


# terraform refresh para mostrar o ssh
output "maquina_master" {
  value = [
    "master - ${aws_instance.maquina_master.public_ip} - ssh -i ~/.ssh/id_rsa ubuntu@${aws_instance.maquina_master.public_dns}"
  ]
}

# terraform refresh para mostrar o ssh
output "aws_instance_e_ssh" {
  value = [
    # for key, item in aws_instance.workers :
    #   "worker ${key+1} - ${item.public_ip} - ssh -i ~/.ssh/id_rsa ubuntu@${item.public_dns}"
    "worker1 - ${aws_instance.worker1.public_ip} - ssh -i ~/.ssh/id_rsa ubuntu@${aws_instance.worker1.public_dns}",
    "worker2 - ${aws_instance.worker2.public_ip} - ssh -i ~/.ssh/id_rsa ubuntu@${aws_instance.worker2.public_dns}",
    "worker3 - ${aws_instance.worker3.public_ip} - ssh -i ~/.ssh/id_rsa ubuntu@${aws_instance.worker3.public_dns}"
  ]
}

# terraform refresh para mostrar o ssh
output "sg_workers" {
  value = [
    "sg dos workers - ${aws_security_group.acessos_workers_single_master.id}"
  ]
}