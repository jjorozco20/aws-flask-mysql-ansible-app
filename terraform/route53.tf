# Route 53 Hosted Zone (replace with your domain)
resource "aws_route53_zone" "main" {
  name = var.zone_name
}

# Route 53 A Record for test-app
resource "aws_route53_record" "test_app" {
  zone_id = aws_route53_zone.main.zone_id
  name    = var.record_name
  type    = "A"
  ttl     = 300
  records = aws_instance.app[*].public_ip
}