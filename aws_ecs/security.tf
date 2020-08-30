# Define the security group for public subnet
resource "aws_security_group" "public_sg" {
  name        = "public-subnet-sg"
  description = "Allow incoming HTTP connections & SSH access"
  vpc_id      = aws_vpc.ecs_vpc.id


  dynamic "ingress" {
    iterator = port
    for_each = var.ingress_ports
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

# Define the security group for private subnet
resource "aws_security_group" "private_sg" {
  name        = "private-subnet-sg"
  description = "Allow traffic from public subnet"
  vpc_id      = aws_vpc.ecs_vpc.id


  dynamic "ingress" {
    iterator = port
    for_each = var.ingress_ports
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = [var.public_subnet_cidr]
    }
  }
}