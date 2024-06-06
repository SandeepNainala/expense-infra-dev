resource "aws_cloudfront_distribution" "web_cdn" {
  origin {
    domain_name = "web-${var.environment}-${var.zone_name}"  #web-dev.devops91.cloud
    origin_id   = "web-${var.environment}-${var.zone_name}"
    custom_origin_config {
      http_port              = 80 # required to be set but not used
      https_port             = 443
      origin_protocol_policy = "https-only"
      origin_ssl_protocols   = ["TLSv1.2", "TLSv1.3"]
    }
  }

  enabled =  true
  aliases = ["web-${var.common_tags.Component}-${var.zone_name}"]  #web-cdn.devops91.cloud

  default_cache_behavior {
    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "web-${var.environment}.${var.zone_name}"

    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
    cache_policy_id  = data.aws_cloudfront_cache_policy.cache_disable.id
  }

  # Cache behavior with precedence 0
  ordered_cache_behavior {
    path_pattern     = "/images/*"
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "web-${var.environment}.${var.zone_name}"

    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
    cache_policy_id  = data.aws_cloudfront_cache_policy.cache_enable.id
  }