# request public certificates from the amazon certificate manager.
resource "aws_acm_certificate" "acm_certificate" {
  # Route 53 --> Dashboard --> Hosted Zone
  # Make sure you have a domain name already in your AWS account

  domain_name               = var.domain_name
  # This is how we request A SSL certificate for our subdomain
  # if a value is a set of string , you neet to put it in a []
  subject_alternative_names = [var.alternative_name]
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

# get details about a route 53 hosted zone
data "aws_route53_zone" "route53_zone" {
  name         = var.domain_name
  private_zone = false
}

# create a record set in route 53 for domain validatation
resource "aws_route53_record" "route53_record" {
  for_each = {
    # for dvo , change to our ssl certificates ressources resource "aws_acm_certificate" "acm_certificate" 
    for dvo in aws_acm_certificate.acm_certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  # Hosted Zone ID data "aws_route53_zone" "route53_zone" 

  zone_id         = data.aws_route53_zone.route53_zone.zone_id
}

# validate acm certificates
resource "aws_acm_certificate_validation" "acm_certificate_validation" {
  certificate_arn         = aws_acm_certificate.acm_certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.route53_record : record.fqdn]
}