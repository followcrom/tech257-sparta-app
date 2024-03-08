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

# Clone your app repository (replace YOUR_GIT_REPO_URL with your actual Git repository URL)
git clone YOUR_GIT_REPO_URL

# Assuming your repository's name is 'app', if not, change the directory name accordingly
cd app

# Install dependencies and run your app
npm install
node app.js
