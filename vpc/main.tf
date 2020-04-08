provider "aws" {
    region = "ap-northeast-1"
}

resource "aws_vpc" "prod" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "Prod"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = "${aws_vpc.prod.id}"
  cidr_block = "10.0.10.0/24"
  map_public_ip_on_launch = "true"

  tags = {
    Name = "ProdPublicSubnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = "${aws_vpc.prod.id}"
  cidr_block = "10.0.20.0/24"

  tags = {
    Name = "ProdPrivateSubnet"
  }
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

resource "aws_route_table_association" "public_rt_binding" {
  subnet_id      = "${aws_subnet.public_subnet.id}"
  route_table_id = "${aws_route_table.public_rt.id}"
}
