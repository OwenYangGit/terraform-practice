output "vpc_id" {
  value = "${aws_vpc.prod.id}"
}

output "igw_id" {
  value = "${aws_internet_gateway.igw.id}"
}
