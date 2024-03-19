# Certificate itself
resource "aws_acm_certificate" "certificate" {
  # Domain name and the *.domain name
  domain_name               = var.site
  subject_alternative_names = ["*.${var.site}"]
  #subject_alternative_names = ["*.${var.site}", local.clean_run_domain]
  validation_method = "DNS"

  tags = {
    app  = var.site
    name = "cert--${replace(var.site, ".", "-")}"
  }

  # Good practice to replace if the cert is in use
  lifecycle {
    create_before_destroy = true
  }
}

# Certificate validation
resource "aws_acm_certificate_validation" "validation" {
  certificate_arn         = aws_acm_certificate.certificate.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]
}

# ---------------------------------------------
# ROUTE 53
# ---------------------------------------------

# Certificate validation records
resource "aws_route53_record" "cert_validation" {
  # Create multiple records to validate the certificate
  for_each = {
    for dvo in aws_acm_certificate.certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 31536000 # 1 year
  type            = each.value.type
  zone_id         = var.aws_hosted_zone_id
}

# Record for redirecting to the CDN
resource "aws_route53_record" "domain_to_cdn" {
  zone_id = var.aws_hosted_zone_id
  name    = var.site
  type    = "A"

  # Alias for the CDN
  alias {
    name                   = aws_cloudfront_distribution.run_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.run_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}
