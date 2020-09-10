provider "aws" {
  region = "us-east-2"

}

resource "aws_instance" "Ubuntu" {
  ami           = "ami-0a63f96e85105c6d3"
  instance_type = "t2.micro"
  tags = {
    Name    = "Ubuntu"
    Owner   = "Sargis"
    Project = "Terrafrom"
  }
}

resource "aws_eip" "static_one" {
  vpc = true

}

resource "aws_eip_association" "EIP_ass" {
  instance_id = aws_instance.Ubuntu.id
  allocation_id = aws_eip.static_one.id
}


resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_eip.static_one.public_ip]
  }

}
