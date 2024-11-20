# Define the IAM Role for EC2 instances (with permission to use CodeDeploy)
resource "aws_iam_role" "ec2_codedeploy_role" {
  name               = "ec2_codedeploy_role"
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })
}

# Attach the AmazonEC2RoleforCodeDeploy policy to allow EC2 instances to interact with CodeDeploy
resource "aws_iam_role_policy_attachment" "codedeploy" {
  role       = aws_iam_role.ec2_codedeploy_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeDeployFullAccess"
}

# Attach S3 Access policy to the IAM role
resource "aws_iam_role_policy_attachment" "s3_readonly_access" {
  role       = aws_iam_role.ec2_codedeploy_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

# Attach SSM Access policy to the IAM role
resource "aws_iam_role_policy_attachment" "ssm_readonly_access" {
  role       = aws_iam_role.ec2_codedeploy_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# Attach RDS Full Access policy to the IAM role
resource "aws_iam_role_policy_attachment" "rds_full_access" {
  role       = aws_iam_role.ec2_codedeploy_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
}

# Define the IAM Instance Profile for EC2
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_instance_profile"
  role = aws_iam_role.ec2_codedeploy_role.name
}
