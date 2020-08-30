resource "aws_lb" "ecs-lb" {
  name               = "test-ecs-lb"
  load_balancer_type = "application"
  internal           = false
  subnets            = [aws_subnet.public_subnet.id]
  tags = {
    "env" = "testing"
  }
  security_groups = [aws_security_group.public_sg.id]
}

resource "aws_lb_target_group" "lb_target_group" {
  name        = "masha-target-group"
  port        = "80"
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = aws_vpc.ecs_vpc.id
  health_check {
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 10
    timeout             = 60
    interval            = 300
    matcher             = "200,301,302"
  }
}

resource "aws_lb_listener" "web-listener" {
  load_balancer_arn = aws_lb.ecs-lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_target_group.arn
  }
}