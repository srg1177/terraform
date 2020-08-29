provider "aws" {
  region     = "us-east-2"
}
resource "aws_instance" "Webserver" {
  ami                    = "ami-0a63f96e85105c6d3"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web_server.id]

  user_data = templatefile("user_data.sh.tpl", {
    f_name = "Sargis",
    l_name = "Hayrapetyan",
    names  = ["Vasya", "Gago", "Ando", "Luiza"]
  })


  tags = {
    Name = "Apache_WebServer"
  }
}

resource "aws_security_group" "web_server" {
  name        = "WebServer security group"
  description = "Allow WebServer in_end traffic"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Allow_WebServer"
  }

}
