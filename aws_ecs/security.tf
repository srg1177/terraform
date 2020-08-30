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
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}


# Traffic from public_sg
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

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}