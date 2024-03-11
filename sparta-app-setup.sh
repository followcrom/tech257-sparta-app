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

echo "Installing Node.js..."
echo

sudo apt-get install -y nodejs

echo "Node.js Installed: version: $(node -v)"
echo 

# Install pm2 globally
sudo npm install pm2@latest -g

echo "Installed pm2"

# Clone the app from GitHub
git clone https://github.com/followcrom/tech257-sparta-app.git

echo "Cloned the app from GitHub"

# Navigate to the app directory
cd tech257-sparta-app/app

# Install dependencies
npm install

echo "Installing dependencies..."

echo "Installed dependencies"

NGINX_CONF_PATH="/etc/nginx/sites-available"

cd $NGINX_CONF_PATH

NGINX_CONF="default"

# Display the full path of the Nginx configuration file being edited
echo "Updating Nginx configuration in: /etc/nginx/sites-available/$NGINX_CONF"
echo


# sudo sed -i '/location \/ {/a \ proxy_pass http://localhost:3000;' $NGINX_CONF

# Check if the proxy_pass directive already exists
if ! sudo grep -q "proxy_pass http://localhost:3000;" $NGINX_CONF; then
    sudo sed -i "proxy_pass http://localhost:3000;" $NGINX_CONF
    echo "Nginx configuration updated to forward requests to port 3000."
else
    echo "Nginx configuration already includes the proxy settings for port 3000."
fi

echo

# Test Nginx configuration for syntax errors
if sudo nginx -t; then
    echo "Nginx configuration syntax is okay."
    sudo systemctl restart nginx
    echo "Nginx restarted successfully."
else
    echo "Error in Nginx configuration. Check the config file at $NGINX_CONF_PATH/$NGINX_CONF."
fi

echo

cd -

if pm2 list | grep -q "online"; then
    pm2 stop all
    echo "Stopped all running processes."
else
    echo "No running processes found."
fi

echo

# Use pm2 to start app and ensure it runs in the background
pm2 start app.js --name "sparta-test-app"
