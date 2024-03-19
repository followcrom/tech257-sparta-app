# Set up a VM on AWS

## Step 1:  Create a VM

Go to the EC2 dashboard and create a new instance.

Image: ubuntu-22.04

Size: t2.micro (free tier)

## Step 3: Connect to the VM

Use SSH to connect to the VM.

## Step 4: Run the setup script:

```bash
#!/bin/bash

sudo apt update -y

sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y

RESTART_CONF_PATH="/etc/needrestart/"

cd $RESTART_CONF_PATH

NEEDRESTART_CONF="needrestart.conf"

sudo nano $NEEDRESTART_CONF

# Automatically restart services without asking
sudo sed -i "s|#\$nrconf{restart} = 'i';|\$nrconf{restart} = 'a';|" $NEEDRESTART_CONF

# Install Nginx
sudo apt install nginx -y

# Restart and enable Nginx to run on startup
sudo systemctl restart nginx
sudo systemctl enable nginx

cd -

# Install Node.js 20.x (this also installs npm as a dependency)
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -

sudo apt-get install -y nodejs

# Install pm2 globally
sudo npm install pm2@latest -g

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
echo "Updating Nginx configuration in: $NGINX_CONF_PATH/$NGINX_CONF"
echo


sudo sed -i 's|try_files $uri $uri/ =404;|proxy_pass http://localhost:3000/;|' $NGINX_CONF

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
```


## Step 5: Done

You're done! You now have a VM on AWS.
```

