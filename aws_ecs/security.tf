# Security group for load balancer
resource "aws_security_group" "lb-sg" {
  name        = "load-balancer-sg"
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


# Security group form ec2
resource "aws_security_group" "ec2-sg" {
  name        = "ec2-sg"
  description = "Allow traffic from load balancer"
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