# Hello, you may notice that some variables are commented. 
# This is in spite of not being able to use those AWS resources within the Free Tier account. 
# They can work, but you are going to be charged if you uncomment them.
# Be aware of it and proceed with caution when uncommenting them.

# AWS Config Variables
variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "aws_access_key" {
  description = "AWS Access Key"
  type        = string
  sensitive   = true
}

variable "aws_secret_key" {
  description = "AWS Secret Key"
  type        = string
  sensitive   = true
}
# -------------------

#VPC VARIABLES
variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "Public subnet CIDR block"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "Private subnet CIDR block"
  type        = string
  default     = "10.0.2.0/24"
}
# -------------------

# RDS variables
variable "db_name" {
  description = "Database name"
  type        = string
  default     = "test_db"
}

variable "db_user" {
  description = "Database username"
  type        = string
  default     = "root"
}

variable "db_password" {
  description = "Database password"
  type        = string
  default     = "adminpassword"
}

variable "rds_instance_type" {
  description = "RDS instance type"
  type        = string
  default     = "db.t3.micro"
}

variable "rds_identifier" {
  description = "RDS identifier"
  type        = string
  default     = "mysql1-5161515"
}

variable "rds_engine_type" {
  description = "RDS engine type"
  type        = string
  default     = "mysql"
}

variable "rds_engine_version" {
  description = "RDS engine version"
  type        = string
  default     = "8.0.32"
}
# -------------------

# EC2 Instance variables
variable "ec2_instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ec2_user" {
  description = "EC2 User"
  type        = string
  default     = "ec2-user"
}

variable "instaces_number" {
  description = "How many App Servers do you want to create"
  type        = number
  default     = 2
}

variable "volume_size" {
   description = "Size of the EC2 volume in GiB"
   type        = number
   default     = 100 # Minimum free-tier eligible volume size
 }
# -------------------

# ECR Variables

# This is within Free tier, but I am using DockerHub instead of it.
# variable "ecr_repo_name" {
#   description = "ECR repository name"
#   type        = string
#   default     = "flask-mysql-app"
# }
# -------------------

# Route 53 Variables
# variable "zone_name" {
#   description = "The domain name for the Route 53 hosted zone"
# }

# variable "record_name" {
#   description = "The name of the record"
# }
# -------------------

# CodeDeploy Variables

# This is within Free tier, but I am using a Dockerfile and Ansible to deliver the app.
# variable "codedeploy_app" {
#   description = "The app name for the CodeDeploy app"
# }

# variable "deploy_group_name" {
#   description = "Name of the app deployment group"
# }
# -------------------
