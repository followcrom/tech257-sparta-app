curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

az login

# Create a storage account

az storage account create --name tech257richardstorage --resource-group tech257 --location uksouth --sku Standard_LRS

# Enable anonymous blob access on storage account

az storage account update --name tech257richardstorage --resource-group tech257 --allow-blob-public-access true

# Wait for 15 seconds to ensure the change has taken effect
sleep 15

# Create a container

az storage container create --name images --account-name tech257richardstorage --public-access blob --auth-mode login

# Download a picture using the curl command

curl -o ~/dice.png https://upload.wikimedia.org/wikipedia/commons/4/47/PNG_transparency_demonstration_1.png

cd

# Rename the picture

mv dice.png dice-demo.png

# Upload a the picture

az storage blob upload --file dice-demo.png --container-name images --name dice-demo.png --account-name tech257richardstorage --auth-mode login

cd /tech257-sparta-app/app/views

# Backup index.ejs
sudo cp index.ejs index.ejs.backup

sudo sed -i 's|</div>|<img src="https://tech257richardstorage.blob.core.windows.net/images/dice-demo.png">\n&|' index.ejs