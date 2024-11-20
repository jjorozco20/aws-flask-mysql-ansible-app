#!/bin/bash
yum update -y

# SSM agent
sudo systemctl restart amazon-ssm-agent

#Python and Flask
yum install -y python3
amazon-linux-extras install -y epel
pip3 install flask flask_sqlalchemy pymysql
