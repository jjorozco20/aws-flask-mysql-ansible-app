# # Define the IAM Role for CodeDeploy
# resource "aws_iam_role" "codedeploy_role" {
#   name               = "codedeploy-role"
#   assume_role_policy = jsonencode({
#     "Version": "2012-10-17",
#     "Statement": [
#       {
#         "Effect": "Allow",
#         "Principal": {
#           "Service": "codedeploy.amazonaws.com"
#         },
#         "Action": "sts:AssumeRole"
#       }
#     ]
#   })
# }

# # Attach the AWSCodeDeployRole policy to the role
# resource "aws_iam_role_policy_attachment" "codedeploy_policy" {
#   role       = aws_iam_role.codedeploy_role.name
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
# }
