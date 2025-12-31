# Export the id of the load balancer security group
output "alb_security_group_id" {
  value = aws_security_group.alb_security_group.id
  
}

# Export the value of our ecs security group
output "ecs_security_group_id" {
  value = aws_security_group.ecs_security_group.id
  
}