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
git clone https://github.com/followcrom/tech257-sparta-app.git

# Assuming your repository's name is 'app', if not, change the directory name accordingly
cd app

# Install dependencies and run your app
npm install

# Install pm2 globally
sudo npm install pm2@latest

# Use pm2 to start your app and ensure it runs in the background
pm2 start app.js --name "sparta-test-app"
