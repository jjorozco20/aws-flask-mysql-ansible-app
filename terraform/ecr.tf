# resource "aws_ecr_repository" "my_ecr" {
#   name = var.ecr_repo_name

#   image_scanning_configuration {
#     scan_on_push = false # No automatic scans
#   }

#   tags = {
#     Environment = "Development"
#     Project     = var.ecr_repo_name
#   }
# }