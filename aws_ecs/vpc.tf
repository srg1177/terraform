# Define the ECS VPC
resource "aws_vpc" "ecs_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc
  }
}


# Define the private subnet
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.ecs_vpc.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = "us-east-2b"

  tags = {
    Name = var.private_subnet
  }
}



# Define the public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.ecs_vpc.id
  cidr_block        = var.public_subnet_cidr
  availability_zone = "us-east-2c"

  tags = {
    Name = var.public_subnet
  }
}




# Define the internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.ecs_vpc.id

  tags = {
    Name = "VPC IGW"
  }
}

# Route the public subnet traffic through the IGW
resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.ecs_vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}


# Create NAT Gateway with Elastic IP
resource "aws_eip" "gw" {
  vpc        = true
  depends_on = [aws_internet_gateway.gw]
}

resource "aws_nat_gateway" "gw" {
  subnet_id     = aws_subnet.public_subnet.id
  allocation_id = aws_eip.gw.id
}

# Create a new route table for the private subnets, make it route non-local traffic through the NAT gateway to the internet
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.ecs_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.gw.id
  }
}

# Assign the route table to the Private  Subnet
resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private.id
}

