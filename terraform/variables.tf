variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

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

# EC2 Instance variables
variable "ec2_instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

# RDS variables
variable "db_name" {
  description = "Database name"
  type        = string
  default     = "app_db"
}

variable "db_user" {
  description = "Database username"
  type        = string
  default     = "root"
}

variable "db_password" {
  description = "Database password"
  type        = string
  default     = "em7admin"
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

variable "zone_name" {
  description = "The domain name for the Route 53 hosted zone"
}

variable "record_name" {
  description = "The name of the record"
}

variable "codedeploy_app" {
  description = "The app name for the CodeDeploy app"
}

variable "deploy_group_name" {
  description = "Name of the app deployment group"
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

variable "ec2_user" {
  description = "RDS engine version"
  type        = string
  default     = "8.0.32"
}

variable "instaces_number" {
  description = "How many App Servers do you want to create"
  type        = number
  default     = 2
}

variable "ecr_repo_name" {
  description = "ECR repository name"
  type        = string
  default     = "flask-mysql-app"
}

variable "volume_size" {
  description = "Size of the EBS volume in GiB"
  type        = number
  default     = 100 # Minimum free-tier eligible volume size
}
