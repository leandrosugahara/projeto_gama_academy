# https://www.terraform.io/docs/language/values/outputs.html
#output "instance_ip_addr" {
#    value = [
##        for key, item in aws_instance.ec2-leandsu-tf:
 #       " PrivateIP: ${item.private_ip} - PublicIP: ${item.public_ip} - ssh -i ~/.ssh/id_rsa ubuntu@${item.public_dns}" 
        #    aws_instance.ec2-leandsu-tf[0].private_ip, 
        #    aws_instance.ec2-leandsu-tf[0].public_ip, 
        #    aws_instance.ec2-leandsu-tf[0].public_dns
#    ]
#    description = "Mostra os IPs publicos e privados da maquina criada."
#}


output "my_subnet_id" {
  value       = var.my_subnet_id
  description = "Sua subnet_id"
}

output "my_ami" {
  value       = var.my_ami
  description = "Seu ami"
}

output "my_instance_type" {
  value       = var.my_instance_type
  description = "Sua instance_type"
}

output "my_vpc_security_group_ids" {
   value       = var.my_vpc_security_group_ids
#  value = [
#      for key, item in aws_instance.ec2-leandsu-tf:
#      "${var.my_vpc_security_group_ids[0]}"
#  ]
  description = "Seu my_vpc_security_group_ids"
}

output "ami_ubunto" {
  value = "${data.aws_ami.ubuntu.id}"
}