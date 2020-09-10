output "VPC_ID" {
  value = aws_vpc.ecs_vpc.id
}

output "Elastic_IP" {
  value = aws_eip.gw.public_ip
}

output "LB_HOSTNAME" {
  value = aws_lb.ecs-lb.dns_name
}