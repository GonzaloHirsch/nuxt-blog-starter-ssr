# CloudFront distribution
resource "aws_cloudfront_distribution" "run_distribution" {
  # Cloud Run origin.
  origin {
    domain_name = local.clean_run_domain
    origin_id   = local.clean_run_domain
    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }
  }

  enabled             = true
  default_root_object = "/"
  price_class         = "PriceClass_All"

  # Domain aliases
  aliases = [var.site, "*.${var.site}"]

  # SSL certificate
  viewer_certificate {
    acm_certificate_arn      = aws_acm_certificate.certificate.arn
    minimum_protocol_version = "TLSv1.2_2021"
    ssl_support_method       = "sni-only"
  }

  # No restrictions
  restrictions {
    geo_restriction {
      locations        = []
      restriction_type = "none"
    }
  }

  # Allow only GET, HEAD, and OPTIONS.
  default_cache_behavior {
    allowed_methods            = ["GET", "HEAD", "OPTIONS"]
    cached_methods             = ["GET", "HEAD", "OPTIONS"]
    target_origin_id           = local.clean_run_domain
    response_headers_policy_id = aws_cloudfront_response_headers_policy.default.id

    # No forwarding at all
    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }

  tags = {
    app  = var.site
    name = "cdn--${replace(var.site, ".", "-")}"
  }
}

# Response headers for distribution
resource "aws_cloudfront_response_headers_policy" "default" {
  name    = "${replace(var.site, ".", "-")}-policy"
  comment = "Policy to ensure security headers are included"

  security_headers_config {
    # No sniffing for content
    content_type_options {
      override = true
    }
    # Iframe embedding configuration
    frame_options {
      frame_option = "DENY"
      override     = true
    }
    # Protection against XSS
    xss_protection {
      override   = true
      protection = true
      mode_block = true
    }
    # Ensure HTTPs
    strict_transport_security {
      access_control_max_age_sec = 31536000
      include_subdomains         = true
      override                   = true
      preload                    = true
    }
  }

  # Removing sensitive headers
  remove_headers_config {
    items {
      header = "Server"
    }
    items {
      header = "Powered-by"
    }
    items {
      header = "ASPNET"
    }
    items {
      header = "ASPNETMVC"
    }
  }
}
