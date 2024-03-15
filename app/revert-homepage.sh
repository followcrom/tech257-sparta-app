# Not suitable for user data
cd /tech257-sparta-app/app/

sudo mv views/index.ejs.backup views/index.ejs

pm2 stop all

pm2 start app.js --name "sparta-test-app"

# Delete the storage account

az storage account delete --name tech257richardstorage --resource-group tech257 --yes