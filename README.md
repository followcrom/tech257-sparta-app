
## Creating a VM on Azure

- **Step 1: Create a New Virtual Machine**
  - On the Azure dashboard, select "Virtual machines".
  - Alternatively, you can search for "Virtual machines" in the search bar.
  - On the "Virtual machines" page, click _Create > Azure virtual machine_. You will be taken through to options to configure the VM.

- **Step 2: Configure Settings**
  - **Subscription**: Choose the _Azure Training_ subscription.
  - **Resource Group**: Choose _tech257_ as the resource group.
  - **Virtual Machine Name**: Enter a name for your VM.
  - **Region**: Select _UK South_ for the Azure region to deploy the VM.
  - **Availability Options**: At this stage, _No infrastructure redundancy required_.
  - **Security**: _Standard_
  - **Image**: Choose the OS image: _Ubuntu Pro 22.04 LTS - Gen2_.
  - **Size**: Choose the VM size based on your performance and cost requirements. In this case _Standard_B1s - 1 vcpu, 1GiB_.

- **Step 3: Administrator Account**
  - Set user name to _adminuser_.
  - We'll use an SSH public key for authentication: an existing public key has already been added to the account.

- **Step 4: Inbound Port Rules**
  - We'll allow port 22 for SSH connections and port 80 for those over HTTP. We can add port 3000 for the app later.

- **Step 5: Disks**
  - We'll use the _Standard SSD_ for the OS disk.
  - Check _Delete with VM_.

- **Step 6: Network Settings**
  - Select a Virtual Network. In this case: _tech257-richard-2subnet-vnet_.
  - Subnet: _public_.
  - NIC network security group: _tech257-richard-vm-from-image-nsg_ (expose ports 22, 80 and 3000).

- **Step 7: Tags**
  - Define a key-value pair for the resource: _Owner: Richard_.

- **Step 8: Review and Create**
  - Review all settings, and then click "Create" to deploy your VM.

Deployment may take a few minutes. Once complete, you can view the VM on the Azure portal, as below:

![Cloud Image](imgs/vms/vm_overview.jpg "Deployed VM")

## Make an Image of a VM

Ensure you have Azure CLI installed. Then, run the following command:

`sudo waagent -deprovision+user`

Deprovisioning is the process of removing user-specific data from the VM to prepare it for being captured as an image.

`az vm deallocate --resource-group tech257 --name <VM_name>`

Deallocating a VM stops the VM and releases the compute resources it was using. This is necessary before capturing an image.

`az vm generalize --resource-group tech257 --name <VM_name>`

Generalizing a VM removes all user-specific information from the VM, including the SSH keys and the user account.

From the Azure portal, navigate to the VM's overview page and click on "Capture".

Create a new image. This time select the image type as the image just captured.

## Connect to VM Using SSH

In the terminal, use the command:

```
ssh -i ~/.ssh/richard-az-key adminuser@172.167.169.127
```

## Run Script on new Image

As the new image is a copy of the original VM, it already has the **nginx server** installed, so we can trim our deploy script a little. However, the app itself is going to be copied to a different location: **/repo/app**, so let's do that:

`sudo git clone https://github.com/followcrom/tech257-sparta-app.git /repo`

`cd /repo/app`

With the a reduced `deploy.sh`, we can attempt to install and start the app. It does not work! However, we do get this helpful error message:

_The operation was rejected by your operating system. It is likely you do not have the permissions to access this file as the current user_

It seems we don't have the permissions needed to install the packages in the **root** dir. Let's change the ownership of the **/repo/app** directory to the current user, with the cmd:

```
sudo chown -R $USER:$USER /repo/app
```

This specifies the new owner and group for the files and directories. `$USER` is an environment variable that represents the current logged-in user's username. When `$USER:$USER` is used in this context, it sets both the owner and the group of the files/directories to the current user.

Now, the **adminuser** has read and write permissions for files and read, write, and execute permissions for directories. This setup should generally be sufficient for running `npm install` in **/repo/app**, assuming you're operating as **adminuser**.

![Cloud Image](imgs/vms/sparta-test-app.jpg "Deployed VM")

## Deleting a VM on Azure

  - On the "Virtual machines" page from the Azure portal dashboard, find and select the VM you wish to delete.
  - On the VM's overview page, click on the "Delete" button.
  - You may be asked to confirm the deletion. Confirm by typing the name of the VM or following the prompt instructions.

**Delete Associated Resources (Optional)**

When deleting a VM, consider if you also want to delete associated resources like disk storage, network interfaces, or public IP addresses. These resources are billed separately and won't be automatically deleted with the VM.

**Verify Deletion**

After deletion, ensure that the VM and any selected associated resources no longer appear in their respective sections within the Azure portal.

**Important Notes**:
- Deleting a VM is irreversible. Ensure you have backed up any necessary data before proceeding.
- Remember that deleting the VM does not automatically delete associated resources like disks or network interfaces, which might incur charges if left undeleted.

![Cloud Image](imgs/vms/vm_delete.jpg "Delete a VM")