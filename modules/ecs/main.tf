# create ecs cluster
resource "aws_ecs_cluster" "ecs_cluster" {
  name      = "${var.project_name}-${var.environment}-cluster"

  setting {
    name    = "containerInsights"
    value   = "disabled"
  }
}

# create cloudwatch log group
resource "aws_cloudwatch_log_group" "log_group" {
  name = "${var.project_name}-${var.environment}-task-definition"

  lifecycle {
    create_before_destroy = true
  }
}

# create task definition
resource "aws_ecs_task_definition" "ecs_task_definition" {
  family                    = "${var.project_name}-${var.environment}-task-definition"
  execution_role_arn        =  var.ecs_tasks_execution_role_arn
  network_mode              = "awsvpc"
  requires_compatibilities  = ["FARGATE"]
  cpu                       = tostring(var.cpu)
  memory                    = tostring(var.memory)

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  container_definitions     = jsonencode([
    {
      name                  = "${}-container"
      image                 = 
      essential             = true

      portMappings          = [
        {
          containerPort     = 
          hostPort          = 
        }
      ]
      
      ulimits = [
        {
          name = "nofile",
          softLimit = 1024000,
          hardLimit = 1024000
        }
      ]

      logConfiguration = {
        logDriver   = "awslogs",
        options     = {
          "awslogs-group"          = 
           "awslogs-region"        = 
          "awslogs-stream-prefix"  = 
        }
      }
    }
  ])
}

# create ecs service
resource "aws_ecs_service" "ecs_service" {
  name              = "${}-service"
  launch_type       = 
  cluster           = 
  task_definition   = 
  platform_version  = 
  desired_count     = 
  deployment_minimum_healthy_percent = 
  deployment_maximum_percent         = 

  # task tagging configuration
  enable_ecs_managed_tags            = 
  propagate_tags                     = 

  # vpc and security groups
  network_configuration {
    subnets                 = []
    security_groups         = [] 
    assign_public_ip        = false
  }

  # load balancing
  load_balancer {
    target_group_arn = 
    container_name   = "${}-container"
    container_port   = 
  }
}