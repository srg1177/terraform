
resource "aws_ecs_cluster" "test-cluster" {
  name               = var.cluster
  capacity_providers = [aws_ecs_capacity_provider.test.name]
  tags = {
    "env"       = "testing"
    "createdBy" = "Sargis H."
  }
}

resource "aws_ecs_capacity_provider" "test" {
  name = "capacity-provider-test"
  auto_scaling_group_provider {
    auto_scaling_group_arn         = aws_autoscaling_group.asg.arn
    managed_termination_protection = "ENABLED"

    managed_scaling {
      status          = "ENABLED"
      target_capacity = 85
    }
  }
}

resource "aws_ecs_task_definition" "task-definition-test" {
  family                = "test"
  container_definitions = file("task-definitions/container-def.json")
  network_mode          = "bridge"
  tags = {
    "env" = "testing"
  }
}

resource "aws_ecs_service" "service" {
  name          = "service"
  cluster       = aws_ecs_cluster.test-cluster.id
  desired_count = 10
  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.app.arn
    container_name   = "example"
    container_port   = 80
  }

  launch_type = "EC2"
  depends_on  = [aws_lb_listener.web-listener]
}

resource "aws_cloudwatch_log_group" "log_group" {
  name = "/ecs/frontend-container"
  tags = {
    "env" = "testing"
  }
}