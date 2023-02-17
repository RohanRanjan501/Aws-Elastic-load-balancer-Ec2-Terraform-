

output "load_balancer_dns_name" {
  value = aws_lb.application_lb.dns_name
}