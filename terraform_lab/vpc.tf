resource "aws_vpc" "my_vpc" {
  cidr_block = "10.80.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "leandsu-vpc-02"
  }
}

resource "aws_subnet" "my_subnet_2a" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.80.0.0/20"
  availability_zone = "us-east-1a"

  tags = {
    Name = "leandsu-subnet-2a"
  }
}

resource "aws_subnet" "my_subnet_2b" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.80.32.0/20"
  availability_zone = "us-east-1b"

  tags = {
    Name = "leandsu-subnet-2b"
  }
}

resource "aws_subnet" "my_subnet_2c" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.80.48.0/20"
  availability_zone = "us-east-1c"

  tags = {
    Name = "leandsu-subnet-2c"
  }
}


#resource "aws_internet_gateway" "gw" {
#   vpc_id = aws_vpc.my_vpc.id

#   tags = {
#     Name = "leandsu-internet-gateway-02"
#   }
# }

resource "aws_route_table" "my_rt" {
  vpc_id = aws_vpc.my_vpc.id

  route = [
      # {
      #   carrier_gateway_id         = ""
      #   cidr_block                 = "0.0.0.0/0"
      #   destination_prefix_list_id = ""
      #   egress_only_gateway_id     = ""
      #   gateway_id                 = aws_internet_gateway.gw.id
      #   instance_id                = ""
      #   ipv6_cidr_block            = ""
      #   local_gateway_id           = ""
      #   nat_gateway_id             = ""
      #   network_interface_id       = ""
      #   transit_gateway_id         = ""
      #   vpc_endpoint_id            = ""
      #   vpc_peering_connection_id  = ""
     # }
  ]

  tags = {
    Name = "leandsu-rt-publica-02"
  }
}




resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.my_subnet_2a.id
  route_table_id = aws_route_table.my_rt.id
}

resource "aws_route_table_association" "b" {
  subnet_id      = aws_subnet.my_subnet_2b.id
  route_table_id = aws_route_table.my_rt.id
}

resource "aws_route_table_association" "c" {
  subnet_id      = aws_subnet.my_subnet_2c.id
  route_table_id = aws_route_table.my_rt.id
}



# resource "aws_network_interface" "my_subnet" {
#   subnet_id           = aws_subnet.my_subnet.id
#   private_ips         = ["172.17.10.100"] # IP definido para instancia
#   # security_groups = ["${aws_security_group.allow_ssh1.id}"]

#   tags = {
#     Name = "primary_network_interface my_subnet"
#   }
# }