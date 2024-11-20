#!/bin/bash

# Define the app directory
APP_DIR="/home/ec2-user/flask-app"

# Navigate to the app directory
cd $APP_DIR || { echo "Failed to change directory to $APP_DIR"; exit 1; }

# Check if requirements.txt exists and install dependencies
echo "Listing files in $APP_DIR to verify if requirements.txt exists:"
ls -l $APP_DIR

if [ -f "requirements.txt" ]; then
    echo "Installing dependencies from requirements.txt..."
    sudo pip3 install -r requirements.txt
else
    echo "requirements.txt not found in $APP_DIR. Please ensure the file exists."
    exit 1
fi
