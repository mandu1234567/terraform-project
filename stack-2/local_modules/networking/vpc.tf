locals {
  public_subnet_count  = var.public_subnet_count
  private_subnet_count = var.private_subnet_count
  az_names             = data.aws_availability_zones.azs.names
}

resource "aws_vpc" "name" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.vpc_name
  }
}

###### Public Subnets
resource "aws_subnet" "public" {
  count = local.public_subnet_count

  vpc_id                  = aws_vpc.name.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 8, count.index)
  availability_zone       = local.az_names[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.vpc_name}-public-subnet-${count.index + 1}"
  }
}

###### Private Subnets
resource "aws_subnet" "private" {
  count = local.private_subnet_count

  vpc_id            = aws_vpc.name.id
  cidr_block        = cidrsubnet(var.vpc_cidr, 8, count.index + 10)
  availability_zone = local.az_names[count.index]

  tags = {
    Name = "${var.vpc_name}-private-subnet-${count.index + 1}"
  }
}

###### Internet Gateway
resource "aws_internet_gateway" "name" {
  vpc_id = aws_vpc.name.id

  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

###### Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.name.id

  tags = {
    Name = "${var.vpc_name}-public-rt"
  }
}

###### Public Route
resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.name.id
}

###### Public Route Table Association
resource "aws_route_table_association" "public" {
  count = local.public_subnet_count

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

###### Elastic IP for NAT
resource "aws_eip" "nat" {
  domain = "vpc"
}

###### NAT Gateway
resource "aws_nat_gateway" "name" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  depends_on = [aws_internet_gateway.name]

  tags = {
    Name = "${var.vpc_name}-nat"
  }
}

###### Private Route Table
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.name.id

  tags = {
    Name = "${var.vpc_name}-private-rt"
  }
}

###### Private Route
resource "aws_route" "private_internet" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.name.id
}

###### Private Route Table Association
resource "aws_route_table_association" "private" {
  count = local.private_subnet_count

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}