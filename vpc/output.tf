output "vpc_id" {
  value = "${aws_vpc.prod.id}"
}

output "vpc_cidr" {
  value = "${aws_vpc.prod.cidr_block}"
}
