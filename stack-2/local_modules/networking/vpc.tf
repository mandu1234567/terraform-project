locals {
  public_subnet_cidr = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
}


resource "aws_vpc" "name" {
    cidr_block = var.vpc_cidr
    tags = {
        Name = var.vpc_name
    }
  
}


######public subnet
resource "aws_subnet" "public" {
  count = length(local.public_subnet_cidr)

  vpc_id            = aws_vpc.name.id
  cidr_block        = local.public_subnet_cidr[count.index]
  availability_zone = var.azs[count.index]

  tags = {
    Name = "${var.vpc_name}-public-subnet-${count.index + 1}"
  }
}

######private subnet
resource "aws_subnet" "private" {
  count = length(local.private_subnet_cidr)

  vpc_id            = aws_vpc.name.id
  cidr_block        = local.private_subnet_cidr[count.index]
  availability_zone = var.azs[count.index]

  tags = {
    Name = "${var.vpc_name}-private-subnet-${count.index + 1}"
  }
}
#######internet gateway
resource "aws_internet_gateway" "name" {
    vpc_id = aws_vpc.name.id
    tags = {
        Name = "${var.vpc_name}-igw"
    }
  
}
####route table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.name.id

  tags = {
    Name = "${var.vpc_name}-public-rt"
  }
}
######route
resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.name.id
}
#######route table association
resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidr)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}


#####elastic ip for nat gateway
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "${var.vpc_name}-nat-eip"
  }
}
######nat gateway
resource "aws_nat_gateway" "name" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    Name = "${var.vpc_name}-nat"
  }

  depends_on = [aws_internet_gateway.name]
}

######route table for private subnet
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.name.id

  tags = {
    Name = "${var.vpc_name}-private-rt"
  }
}

######route for private subnet to access internet via nat gateway
resource "aws_route" "private_internet" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.name.id
}

######route table association for private subnet
resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_cidr)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}