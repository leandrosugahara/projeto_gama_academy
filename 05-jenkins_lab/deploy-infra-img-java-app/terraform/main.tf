provider "aws" {
  region = "sa-east-1"
}

# data "http" "myip" {
#   url = "http://ipv4.icanhazip.com" # outra opção "https://ifconfig.me"
# }

resource "aws_instance" "dev_img_deploy_jenkins" {
  ami           = "ami-0e66f5495b4efdd0f"
  instance_type = "t2.micro"
  key_name      = "leandsu_ec2_dev"
  subnet_id                   = "subnet-037d9188710cf6ac2"
  associate_public_ip_address = true
  root_block_device {
    encrypted   = true
    volume_size = 8
  }
  tags = {
    Name = "dev_img_deploy_jenkins-leandsu"
  }
  vpc_security_group_ids = [aws_security_group.acesso_jenkins_dev_img.id]
}

resource "aws_security_group" "acesso_jenkins_dev_img" {
  name        = "acesso_jenkins_dev_img"
  description = "acesso_jenkins_dev_img inbound traffic"
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
      from_port        = 80
      to_port          = 80
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
    Name = "jenkins-dev-img-lab-leandsu"
  }
}

# terraform refresh para mostrar o ssh
output "dev_img_deploy_jenkins" {
  value = [
    "resource_id: ${aws_instance.dev_img_deploy_jenkins.id}",
    "public_ip: ${aws_instance.dev_img_deploy_jenkins.public_ip}",
    "public_dns: ${aws_instance.dev_img_deploy_jenkins.public_dns}",
    "ssh -i /var/lib/jenkins/.ssh/id_rsa ubuntu@${aws_instance.dev_img_deploy_jenkins.public_dns}"
  ]
}
