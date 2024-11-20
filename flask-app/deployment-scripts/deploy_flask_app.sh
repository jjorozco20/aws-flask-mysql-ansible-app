#!/bin/bash

# Define directories
APP_DIR="/home/ec2-user/flask-app"
SOURCE_DIR="/src"

# Ensure the directory exists
echo "Creating target directory if it doesn't exist..."
mkdir -p $APP_DIR

# Copy Flask application code from source to destination
echo "Copying files from $SOURCE_DIR to $APP_DIR"
cp -r $SOURCE_DIR/* $APP_DIR/

# Set the appropriate permissions
chown -R ec2-user:ec2-user $APP_DIR

# Verify that the files are copied correctly
echo "Verifying copied files..."
ls -l $APP_DIR

echo "Flask app code copied to $APP_DIR"
