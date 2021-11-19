provider "aws" {
  region = "sa-east-1"
}

resource "aws_instance" "ec2-leandsu-tf1" {
    subnet_id = "subnet-037d9188710cf6ac2"
    ami= "ami-0e66f5495b4efdd0f"
    instance_type = "t3.medium"
    vpc_security_group_ids = ["sg-05fb5f608a43df40f"] 
    key_name = "leandsu_ec2_dev"
    associate_public_ip_address = true
    root_block_device {
      encrypted = true
      volume_size = 8
    }
    tags = {
       Name = "ec2-leandsu-tf1"
    }
}

resource "aws_key_pair" "leandsu_ec2_devcd" {
    key_name = "leandsu_ec2_dev"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDd6OMOvF6Ds+haId5fXoLojBajtlKoFt4qp1nSPUABS2RwCaYkxjbLM2YHZbgYHrjhJzyxKduKyOJt2NMvfmlDWTwKrAiOzhKdCrkqMh8NlyoWBoh2q28Gs9yix1ffXwbUR3mSORNu71RCzgI7DYCZ4AWXYHwKJF2VYIYbl6G2acWu6XDrv5/FagG3oUvuHiPy4rHrQwLuzbgc48/xpre6tIhmPwems13tPHcFzjgSlvb3bZm/D8J60jWKKCBJqD+nO4x0PbrA1HT75DBqv3VrfGyQ9RxTuNsKRbq4vCy/uRgbFeYDuywT6ULBi90OW4XFYL6lWWNQCq1Zx52rtIELVj2UHCqUkb83ahS2mmWfIvdQBo4CoU8rpfUSYZ1O1Til/Ipo96VButmx0+bW0JVuGEn2X/xPs8LPtfZwT5X2Dn4DFAqp5d1HyKvnqA5iDZdyAwbhbwjgTbK0ve/Ev+vRn1JBSTQ3K5qL7On1IJNVfrMCqgBPa+Z04HfZhNzT3ks= ubuntu@ec2-leandsu-dev"
}