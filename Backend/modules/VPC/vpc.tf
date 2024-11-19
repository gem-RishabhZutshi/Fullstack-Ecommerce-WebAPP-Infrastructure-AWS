# Define the VPC
resource "aws_vpc" "ecommerce_app_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "EcommerceApp-VPC"
  }
}

# Define the internet gateway
resource "aws_internet_gateway" "ecommerce_app_vpc_igw" {
  vpc_id = aws_vpc.ecommerce_app_vpc.id

  tags = {
    Name = "EcommerceApp-VPC-igw"
  }
}

resource "aws_eip" "nat_eip_one" {
  tags = {
    Name = "${var.project_name}-${var.environment}-nat-eip-one"
  }
}

resource "aws_eip" "nat_eip_two" {
  tags = {
    Name = "${var.project_name}-${var.environment}-nat-eip-two"
  }
}

resource "aws_nat_gateway" "ecommerce_app_vpc_NAT_one" {
  allocation_id = aws_eip.nat_eip_one.id
  subnet_id     = aws_subnet.public_subnet1.id
  tags = {
    Name = "${var.project_name}-${var.environment}-nat-gateway-one"
  }
}

resource "aws_nat_gateway" "ecommerce_app_vpc_NAT_two" {
  allocation_id = aws_eip.nat_eip_two.id
  subnet_id     = aws_subnet.public_subnet2.id
  tags = {
    Name = "${var.project_name}-${var.environment}-nat-gateway-two"
  }
}


# Define two public subnets in different availability zones
resource "aws_subnet" "public_subnet1" {
  vpc_id     = aws_vpc.ecommerce_app_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1a"

  map_public_ip_on_launch = true

  tags = {
    Name = "EcommerceApp-VPC-public-subnet-1"
  }
}

resource "aws_subnet" "public_subnet2" {
  vpc_id     = aws_vpc.ecommerce_app_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-south-1b"

  map_public_ip_on_launch = true

  tags = {
    Name = "EcommerceApp-VPC-public-subnet-2"
  }
}


# Define two private subnets in different availability zones
resource "aws_subnet" "private_subnet1" {
  vpc_id     = aws_vpc.ecommerce_app_vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "EcommerceApp-VPC-private-subnet-1"
  }
}

resource "aws_subnet" "private_subnet2" {
  vpc_id     = aws_vpc.ecommerce_app_vpc.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "ap-south-1b"

  tags = {
    Name = "EcommerceApp-VPC-private-subnet-2"
  }
}


# Create a route table for public subnets
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.ecommerce_app_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ecommerce_app_vpc_igw.id
  }

  tags = {
    Name = "EcommerceApp-VPC-public-route-table"
  }
}

# Create a route table for private subnets
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.ecommerce_app_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ecommerce_app_vpc_NAT_one.id
  }

  tags = {
    Name = "EcommerceApp-VPC-private-route-table-one"
  }
}

resource "aws_route_table" "private_route_table_two" {
  vpc_id = aws_vpc.ecommerce_app_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ecommerce_app_vpc_NAT_two.id
  }

  tags = {
    Name = "EcommerceApp-VPC-private-route-table-two"
  }
}

# Associate public subnets with the route table
resource "aws_route_table_association" "public_subnet1_association" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_subnet2_association" {
  subnet_id      = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.public_route_table.id
}

# Associate private subnets with the route table
resource "aws_route_table_association" "private_subnet1_association" {
  subnet_id      = aws_subnet.private_subnet1.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_subnet2_association" {
  subnet_id      = aws_subnet.private_subnet2.id
  route_table_id = aws_route_table.private_route_table_two.id
}

