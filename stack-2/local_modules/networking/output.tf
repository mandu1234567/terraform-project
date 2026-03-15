output "vpc_id" {
  value = aws_vpc.id
}
output "vpc_id_cidr" {
  value = aws_vpc.cidr_block
}
output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}
output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}