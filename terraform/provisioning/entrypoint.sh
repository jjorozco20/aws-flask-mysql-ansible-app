#!/bin/bash

# Exit immediately if a command fails
set -e

echo "Running Terraform..."
terraform apply -auto-approve

echo "Waiting for resources to be ready..."
sleep 120

echo "Running Ansible playbook with DB_ENDPOINT=${DB_ENDPOINT}..."
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i $(terraform output -raw elastic_ip_instance), \
    --private-key /app/ssh_key \
    -u ec2-user \
    -e "db_endpoint=${DB_ENDPOINT}" \
    deploy.yml