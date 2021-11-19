# ///////// do leandsu //////
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "ec2-leandsu-tf1" {
# for_each = toset(["serv1", "servA", "servA" ])  
  #count = 1
  #  subnet_id = "subnet-037d9188710cf6ac2"
  #  ami= "ami-0e66f5495b4efdd0f"
  #  instance_type = "t2.micro"
  #  vpc_security_group_ids = ["sg-05fb5f608a43df40f"]
    subnet_id = aws_subnet.my_subnet_2a.id
  #  ami= var.my_ami
    ami= "${data.aws_ami.ubuntu.id}"
    instance_type = var.my_instance_type
  #  vpc_security_group_ids = var.my_vpc_security_group_ids 
  #  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]  
    vpc_security_group_ids  = ["${aws_security_group.allow_ssh_terraform.id}"]
  #  key_name = var.my_key_name
    associate_public_ip_address = true
    root_block_device {
      encrypted = true
      volume_size = 8
    }
    tags = {
       Name = "ec2-leandsu-tf1"
#      Name = "ec2-leandsu-tf${(count.index)}"
#      Name = "ec2-${each.key}-tf"      
    }
}

resource "aws_instance" "ec2-leandsu-tf2" {
    subnet_id = aws_subnet.my_subnet_2b.id
    ami= "${data.aws_ami.ubuntu.id}"
    instance_type = var.my_instance_type
    vpc_security_group_ids  = ["${aws_security_group.allow_ssh_terraform.id}"]
  #  key_name = var.my_key_name
    associate_public_ip_address = true
    root_block_device {
      encrypted = true
      volume_size = 8
    }
    tags = {
       Name = "ec2-leandsu-tf2"
    }
}

resource "aws_instance" "ec2-leandsu-tf3" {
    subnet_id = aws_subnet.my_subnet_2c.id
    ami= "${data.aws_ami.ubuntu.id}"
    instance_type = var.my_instance_type
    vpc_security_group_ids  = ["${aws_security_group.allow_ssh_terraform.id}"] 
  #  key_name = var.my_key_name
    associate_public_ip_address = true
    root_block_device {
      encrypted = true
      volume_size = 8
    }
    tags = {
       Name = "ec2-leandsu-tf3"
    }
}

module "criar_instancia_private" {
  source = "./private_ec2"
  nome_ec2_private = "ec2-leandsu-tf4"
#  subnet_id_modulo = aws_subnet.my_subnet_2d_private.id
  vpc_id_modulo = "${aws_vpc.my_vpc.id}"
  ami_modulo =  "${data.aws_ami.ubuntu.id}"
  vpc_security_group_ids_modulo = aws_security_group.allow_ssh_terraform.id

}

####### exerciocio copia da pasta 17-17-resource_vpc_com_ec2_e_subnet_public_dns

#resource "aws_instance" "web" {
#  ami                     = data.aws_ami.ubuntu.id
#  instance_type           = "t3.micro"
#  key_name                = "treinamento-turma1_itau" # key chave publica cadastrada na AWS 
#  subnet_id               =  aws_subnet.my_subnet.id # vincula a subnet direto e gera o IP automático
#  private_ip              = "172.17.0.100"
#  vpc_security_group_ids  = [
#    "${aws_security_group.allow_ssh_terraform.id}",
#  ]#
#
#  tags = {
#    Name = "Maquina para testar VPC do terraform"
#  }
#}

#/////