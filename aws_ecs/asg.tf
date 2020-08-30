resource "aws_launch_configuration" "lc" {
  name          = "test_ecs"
  image_id      = data.aws_ami.ecs_asg_ami.id
  instance_type = "t2.micro"
  lifecycle {
    create_before_destroy = true
  }
  iam_instance_profile        = aws_iam_instance_profile.ecs_service_role.name
  key_name                    = var.key_name
  security_groups             = [aws_security_group.public_sg.id]
  associate_public_ip_address = true
  user_data                   = <<EOF
#! /bin/bash
sudo apt-get update
sudo echo "ECS_CLUSTER=${var.cluster}" >> /etc/ecs/ecs.config
EOF
}

resource "aws_autoscaling_group" "asg" {
  name                      = "test-asg"
  launch_configuration      = aws_launch_configuration.lc.name
  min_size                  = 2
  max_size                  = 4
  desired_capacity          = 3
  health_check_type         = "ELB"
  health_check_grace_period = 300
  vpc_zone_identifier       = [aws_subnet.public_subnet.id]

  target_group_arns     = [aws_lb_target_group.app.arn]
  protect_from_scale_in = true

  lifecycle {
    create_before_destroy = true
  }
}