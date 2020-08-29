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

resource "aws_instance" "m_Amazon" {
  ami           = "ami-0bdcc6c05dec346bf"
  instance_type = "t2.micro"
  tags = {
    Name    = "Amazon Linux"
    Owner   = "Sargis"
    Project = "Terrafrom"
  }
}
