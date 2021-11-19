resource "aws_instance" "ec2-leandsu-tf4" {
    subnet_id = aws_subnet.my_subnet_2d_private.id
    ami= "${var.ami_modulo}"
    instance_type = "t2.micro"
    vpc_security_group_ids  = ["${var.vpc_security_group_ids_modulo}"]  
  #  key_name = "chave_privada_mysql_leandsu"
    associate_public_ip_address = true
    root_block_device {
      encrypted = true
      volume_size = 8
    }
  tags = {
    Name = "${var.nome_ec2_private}"
  }
}