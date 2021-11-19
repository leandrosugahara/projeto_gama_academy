
resource "aws_subnet" "my_subnet_2d_private" {
#  vpc_id            = aws_vpc.my_vpc.id
  vpc_id = var.vpc_id_modulo
  cidr_block        = "10.80.96.0/20"
  availability_zone = "us-east-1a"

  tags = {
    Name = "leandsu-subnet-2d-private"
  }
}
resource "aws_route_table" "my_rt_private" {
  #vpc_id = aws_vpc.my_vpc.id
  vpc_id = var.vpc_id_modulo
  route = [
  ]

  tags = {
    Name = "leandsu-rt-privada-02"
  }
}

resource "aws_route_table_association" "d" {
  subnet_id      = aws_subnet.my_subnet_2d_private.id
  route_table_id = aws_route_table.my_rt_private.id
}