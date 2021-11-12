# https://www.terraform.io/docs/language/values/outputs.html
output "instance_ip_addr" {
    value = [
      " PrivateIP: ${aws_instance.ec2-leandsu-tf1.private_ip} - PublicIP: ${aws_instance.ec2-leandsu-tf1.public_ip} - ssh -i ~/.ssh/id_rsa ubuntu@${aws_instance.ec2-leandsu-tf1.public_dns}" 
    ]
    description = "Mostra os IPs publicos e privados da maquina criada."
}
