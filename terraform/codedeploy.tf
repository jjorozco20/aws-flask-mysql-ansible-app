# resource "aws_codedeploy_app" "flask_app" {
#   name = "flask_app"
# }

# resource "aws_codedeploy_deployment_group" "flask_deployment" {
#   app_name              = aws_codedeploy_app.flask_app.name
#   deployment_group_name = var.deploy_group_name
#   service_role_arn      = aws_iam_role.codedeploy_role.arn

#   deployment_config_name = "CodeDeployDefault.AllAtOnce"
#   ec2_tag_set {
#     ec2_tag_filter {
#       key   = "Name"
#       type  = "KEY_AND_VALUE"
#       value = "flask_app_instance"
#     }
#   }
# }
