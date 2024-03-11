#!/bin/bash

# Navigate to the app directory
cd /repo/app

echo "Installing dependencies..."

# Install dependencies
npm install

echo "Installed dependencies"

if pm2 list | grep -q "online"; then
    pm2 stop all
    echo "Stopped all running processes."
else
    echo "No running processes found."
fi

echo

# Use pm2 to start app and ensure it runs in the background
pm2 start app.js --name "sparta-test-app"
