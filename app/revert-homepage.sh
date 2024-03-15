sudo mv views/index.ejs.backup views/index.ejs

# Navigate to the app directory
cd /tech257-sparta-app/app

pm2 stop all

pm2 start app.js --name "sparta-test-app"

# Delete the storage account

az storage account delete --name tech257richardstorage --resource-group tech257 --yes