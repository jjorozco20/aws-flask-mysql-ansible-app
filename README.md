# aws-flask-mysql-ansible-app
In this project you will see how to deploy a full infrastructure with 2 EC2 servers and a loadbalancer using RDS MySQL instance and also provisioning the Amazon Linux 2 servers with Ansible and CodeDeploy. Have fun.

---

### Once that you have this repo cloned on your local, these are the requirements to accomplish before you get started: 

---

#### Get a Free Tier AWS account.  

Note: You will need to add a credit/debit card to be able to register. 

#### Install Terraform 

This is the page in where you can find the installation method for your OS 

https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli 

#### Install Docker 

This is the page in where you can find the installation method for your OS 

https://docs.docker.com/desktop/setup/install/windows-install/ 

#### Install AWS CLI 

You can follow this page based on your OS 

https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html 

#### Go to IAM and then select create New User

Add the role AWSAdministratorAccess to your new user and there it is. Enable MFA to avoid people entering into your account and creating resources that may cost on you.

Now that you have whole requirements, then you need to go to you user and to create to it an access key to have the perms to read/write on AWS. 

---

To start this project you need to add a file that is called `*.auto.tfvars`. It will store all the variables that are defined in `variables.tf`, so add it and sync it with your AWS Access key and Secret value.

```
# poc.auto.tfvars

# AWS Region
region = "YOUR REGION"

# VPC and Subnet CIDRs
vpc_cidr = "10.0.0.0/16" # common default values
public_subnet_cidr = "10.0.1.0/24" # common default values
private_subnet_cidr = "10.0.2.0/24" # common default values

# RDS Variables
db_name     = "DB NAME"
db_user     = "DB USER"
db_password = "DB PASSWORD"

aws_access_key = "YOUR ACCESS KEY"
aws_secret_key = "YOUR SECRET KEY"
zone_name      = "example.com" # Required, not implemented yet, leave it as that, it is for Route 53
record_name    = "test-app"    # Required, not implemented yet, leave it as that, it is for Route 53
codedeploy_app = "FLASK APP NAME"
deploy_group_name = "DEPLOYMENT GROUP"
# ecr_repo_name = "ECR REPO NAME" DISABLED FOR NOW, using Docker Hub

```

Now you have whole variables defined:

# If you are in windows: 

### First off, remember to turn on your Docker Desktop, doesn't turn on manually


# If not of if you are done with it:

## Run 

1. `terraform init`

To pull the AWS provider files to work with.

2. `terraform plan`

To see what is going to create and to see certain outputs to avoid going to AWS Console, such as EC2s IPs, Loadbalancer IP, RDS endpoint and many more.

3. `terraform apply`

To... You know, I don't think I need to explain it.

And there you go. Remember to check the AWS console each time you are done with. Also, if you want to use [Terraform Cloud](https://app.terraform.io/session) to track in a better way your deployment, do this:

1. `terraform login`

Then follow their steps and there you go.

2. `terraform init`

3. `terraform plan`

4. `terraform apply`
