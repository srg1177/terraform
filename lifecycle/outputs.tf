output "myserver_id" {
  value = aws_instance.Webserver.id
}

output "myserver_public_ip" {
  value = aws_eip.static_ip.public_ip
}