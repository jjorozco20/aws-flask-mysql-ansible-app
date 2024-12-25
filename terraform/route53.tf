# Hello, you may notice that some resources are commented. 
# This is in spite of not being able to use those AWS resources within the Free Tier account. 
# They can work, but you are going to be charged if you uncomment them.
# Be aware of it and proceed with caution when uncommenting them.

# # Route 53 Hosted Zone (replace with your domain)
# resource "aws_route53_zone" "main" {
#   name = var.zone_name
# }

# # Route 53 A Record for test-app
# resource "aws_route53_record" "test_app" {
#   zone_id = aws_route53_zone.main.zone_id
#   name    = var.record_name
#   type    = "A"
#   ttl     = 300
#   records = aws_instance.app[*].public_ip
# }