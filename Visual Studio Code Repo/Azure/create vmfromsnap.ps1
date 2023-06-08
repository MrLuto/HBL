# Verified per Raman Kumar as of 2/23/2022
#####################
#Draai script in azure bash portal!#
########################

# <FullScript>
#Provide the subscription Id of the subscription where you want to create Managed Disks
subscriptionId="e7b30306-bcb1-43d3-bd25-6c3f78e5a329"

#Provide the name of your resource group
resourceGroupName=AVD

#Provide the name of the snapshot that will be used to create Managed Disks
snapshotName=avdmachinesnap

#Provide the name of the Managed Disk
osDiskName=testdisk

#Provide the size of the disks in GB. It should be greater than the VHD file size.
diskSize=128

#Provide the storage type for Managed Disk. Premium_LRS or Standard_LRS.
storageType=Premium_LRS

#Provide the OS type
osType=Windows

#Provide the name of the virtual machine
virtualMachineName=avdtestvm


#Set the context to the subscription Id where Managed Disk will be created
az account set --subscription $subscriptionId

#Get the snapshot Id 
snapshotId=$(az snapshot show --name $snapshotName --resource-group $resourceGroupName --query [id] -o tsv)

#Create a new Managed Disks using the snapshot Id
az disk create --resource-group $resourceGroupName --name $osDiskName --sku $storageType --size-gb $diskSize --source $snapshotId 

#Create VM by attaching created managed disks as OS
az vm create --name $virtualMachineName --resource-group $resourceGroupName --attach-os-disk $osDiskName --os-type $osType --size Standard_d4as_v5
# </FullScript>