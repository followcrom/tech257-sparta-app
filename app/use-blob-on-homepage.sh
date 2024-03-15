# curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

az login

# Create a storage account

az storage account create --name tech257richardstorage --resource-group tech257 --location uksouth --sku Standard_LRS

# Enable anonymous blob access on storage account

az storage account update --name tech257richardstorage --resource-group tech257 --allow-blob-public-access true

# Create a container

az storage container create --name imgs --account-name tech257richardstorage --auth-mode login

# NOTE: This DOES NOT work. Returns "The specified resource does not exist."
az storage container set-permission --name imgs --account-name tech257richardstorage --auth-mode login --public-access container --debug --permissions "r"


# Issue the command to set permissions on the container
# az storage container set-permission --account-name <account_name> --name <container_name> --permissions <permissions>

# Wait until the permissions have been applied
while true
do
  # Check the status of the container
  status=$(az storage container show --account-name tech257richardstorage --name imgs --query "publicAccess" --output tsv)

  # If the permissions have been applied, break out of the loop
  if [ "$status" = "container" ]; then
    break
  fi

  # If the permissions have not been applied, wait for 5 seconds before checking again
  sleep 5
done

# Delay for 15 seconds

sleep 15

# Download a picture using the curl command

curl -o ~/dice.png https://upload.wikimedia.org/wikipedia/commons/4/47/PNG_transparency_demonstration_1.png

cd

# Rename the picture

mv dice.png dice-demo.png

# Upload a the picture

az storage blob upload --file dice-demo.png --container-name imgs --name dice-demo.png --account-name tech257richardstorage --auth-mode login

# NOTE: This DOES NOT work. is this a permissions issue?
az storage blob update --container-name imgs --name dice-demo.png --account-name tech257richardstorage --auth-mode login --content-cache-control "public, max-age=86400"

cd /tech257-sparta-app/app/views

# Backup index.ejs
sudo cp index.ejs index.ejs.backup

sudo sed -i 's|</div>|<img src="https://tech257richardstorage.blob.core.windows.net/imgs/dice-demo.png">\n&|' index.ejs