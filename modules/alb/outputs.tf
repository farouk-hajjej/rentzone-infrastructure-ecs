# Export Target group Arn
output "alb_target_group_arn" {
  value = aws_lb_target_group.alb_target_group.arn
}

# Export The Application Load Balencer DNS Name
output "application_load_balancer_dns_name" {
  value = aws_lb.application_load_balancer.dns_name
}

# Export The Application Load Balencer Zone Id
output "application_load_balancer_zone_id" {
  value = aws_lb.application_load_balancer.zone_id
}