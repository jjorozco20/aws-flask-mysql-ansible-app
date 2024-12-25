#!/bin/bash
# Install dependencies
yum update -y
yum install -y ansible

# Export application server IPs as an environment variable
export APP_SERVER_IPS='${app_server_ips}'

# Log the IPs for debugging purposes
echo "App Server IPs: $APP_SERVER_IPS" >> /var/log/user-data.log

# Copy the playbook and run it
mkdir -p /ansible
echo "${deploy_playbook_content}" > /ansible/playbook.yml

# Disable host key checking for Ansible
echo "ANSIBLE_HOST_KEY_CHECKING=False" > /etc/ansible/ansible.cfg

# Run the Ansible playbook
ansible-playbook -i localhost, /ansible/playbook.yml -u ec2-user

