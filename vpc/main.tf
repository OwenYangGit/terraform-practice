provider "aws" {
    region = "ap-northeast-1"
}

resource "aws_vpc" "prod" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Prod"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id     = "${aws_vpc.prod.id}"
  cidr_block = "10.0.10.0/24"
  map_public_ip_on_launch = "false"
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "ProdPublicSubnet-AZ1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id     = "${aws_vpc.prod.id}"
  cidr_block = "10.0.110.0/24"
  map_public_ip_on_launch = "false"
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = "ProdPublicSubnet-AZ2"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id     = "${aws_vpc.prod.id}"
  cidr_block = "10.0.20.0/24"
  availability_zone = "ap-northeast-1a"

  tags = {
    Name = "ProdPrivateSubnet-AZ1"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id     = "${aws_vpc.prod.id}"
  cidr_block = "10.0.120.0/24"
  availability_zone = "ap-northeast-1c"

  tags = {
    Name = "ProdPrivateSubnet-AZ2"
  }
}
resource "aws_eip" "nateip" {
  vpc      = true
}
resource "aws_nat_gateway" "natgw" {
  allocation_id = "${aws_eip.nateip.id}"
  subnet_id     = "${aws_subnet.public_subnet_1.id}"
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.prod.id}"

  tags = {
    Name = "ProdInternetGateway"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = "${aws_vpc.prod.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }
}
resource "aws_route_table" "private_rt" {
  vpc_id = "${aws_vpc.prod.id}"

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${aws_nat_gateway.natgw.id}"
  }
}

resource "aws_route_table_association" "public_rt_binding_1" {
  subnet_id      = "${aws_subnet.public_subnet_1.id}"
  route_table_id = "${aws_route_table.public_rt.id}"
}

resource "aws_route_table_association" "public_rt_binding_2" {
  subnet_id      = "${aws_subnet.public_subnet_2.id}"
  route_table_id = "${aws_route_table.public_rt.id}"
}
resource "aws_route_table_association" "private_rt_binding_1" {
  subnet_id      = "${aws_subnet.private_subnet_1.id}"
  route_table_id = "${aws_route_table.private_rt.id}"
}
resource "aws_route_table_association" "private_rt_binding_2" {
  subnet_id      = "${aws_subnet.private_subnet_2.id}"
  route_table_id = "${aws_route_table.private_rt.id}"
}
