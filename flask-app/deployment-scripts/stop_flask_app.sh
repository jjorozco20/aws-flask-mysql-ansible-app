#!/bin/bash

# Define the process name
PROCESS_NAME="gunicorn"

# Find the process and kill it
echo "Stopping Flask app..."
pkill -f $PROCESS_NAME
