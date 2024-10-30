resource "aws_cloudfront_distribution" "this" {
  origin {
    domain_name = "${var.bucket_name}.s3.amazonaws.com"
    origin_id   = "S3-${var.bucket_name}"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.this.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "CDN for ${var.bucket_name}"
  default_root_object = "index.html"
  aliases             = [var.domain_name]

  default_cache_behavior {
    target_origin_id       = "S3-${var.bucket_name}"
    viewer_protocol_policy = "allow-all"

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    min_ttl     = 0
    default_ttl = 3600
    max_ttl     = 86400
    compress    = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
    # We'll update this when we have SSL set up
    # acm_certificate_arn = var.certificate_arn
    # ssl_support_method  = "sni-only"
  }

  tags = {
    Environment = "prod"
    Name        = "CDN for ${var.bucket_name}"
  }
}

resource "aws_cloudfront_origin_access_identity" "this" {
  comment = "OAI for ${var.bucket_name}"
}

output "domain_name" {
  value = aws_cloudfront_distribution.this.domain_name
}

output "origin_access_identity_arn" {
  value = aws_cloudfront_origin_access_identity.this.iam_arn
}
