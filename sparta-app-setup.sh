#!/bin/bash

# Update and upgrade packages
sudo apt update -y
sudo apt upgrade -y

# Install Nginx
sudo apt install nginx -y

# Restart and enable Nginx to run on startup
sudo systemctl restart nginx
sudo systemctl enable nginx

# Install Node.js 20.x (this also installs npm as a dependency)
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install pm2 globally
sudo npm install pm2@latest -g

# Clone the app from GitHub
git clone https://github.com/followcrom/tech257-sparta-app.git

# Navigate to the app directory
cd tech257-sparta-app/app

# Install dependencies
npm install

# Run your app
# node app.js

# Use pm2 to start your app and ensure it runs in the background
pm2 start app.js
