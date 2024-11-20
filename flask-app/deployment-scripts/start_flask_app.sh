#!/bin/bash

# Define Flask app directory and Gunicorn config
APP_DIR="/home/ec2-user/flask-app"
GUNICORN_CMD="gunicorn --bind 127.0.0.1:5000 --workers 3 app:app"

# Navigate to the Flask app directory
cd $APP_DIR

# Start the Flask app with Gunicorn
echo "Starting Flask app..."
$GUNICORN_CMD &
