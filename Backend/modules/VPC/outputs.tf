output "ecommerce_app_vpc_id" {
  value = aws_vpc.ecommerce_app_vpc.id
}

output "ecommerceApp-VPC-public-subnet-one" {
    value = aws_subnet.public_subnet1.id
}

output "ecommerceApp-VPC-public-subnet-two" {
    value = aws_subnet.public_subnet2.id
}

output "ecommerceApp-VPC-private-subnet-one" {
    value = aws_subnet.private_subnet1.id
}

output "ecommerceApp-VPC-private-subnet-two" {
    value = aws_subnet.private_subnet2.id
}