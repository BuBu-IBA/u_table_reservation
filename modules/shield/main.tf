resource "aws_shield_protection" "cloudfront_protection" {
  name     = "cloudfront-protection"
  resource_arn = var.distribution_arn
}