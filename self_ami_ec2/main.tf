provider "aws" {
  region = "us-east-2"
}
data "aws_ami" "my_image" {
  most_recent = true
  owners      = ["self"]
  filter {
    name   = "name"
    values = ["nginx-*"]
  }
}
resource "aws_instance" "my_nginx_server" {
  ami           = data.aws_ami.my_image.id
  instance_type = "t2.micro"
  tags = {
    Name  = "My web server"
    Owner = "Sargis"
  }
}