provider "aws" {
  region     = "us-east-2"
}
resource "aws_instance" "Webserver" {
  ami                    = "ami-0a63f96e85105c6d3"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web_server.id]
  user_data              = <<EOF
#!/bin/bash
apt -y update
apt -y install apache2
echo "Web Server is UP ! " > /var/www/html/index.html
sudo servcie apache2 start
sudo update-rc.d apache2 defaults
EOF

  tags = {
    Name = "Apache_WebServer"
  }

}

resource "aws_security_group" "web_server" {
  name        = "WebServer security group"
  description = "Allow WebServer inbouweb_servernd traffic"

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
