# Export our domain name
output "domain_name" {
  value = var.domain_name
}
# Export the Arn of our certificate 
output "certificate_arn" {
  value = aws_acm_certificate.acm_certificate.arn

}
