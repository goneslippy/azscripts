
rg=$storerg
sa=state$RANDOM
container=$storecontainer-$RANDOM
located="eastus2"
storagesub=$(az account list --query "[?isDefault]" | jq .[].name | tr -d '""' | sed -e 's/ /_/g')

# Create Resource group

az group create --name "$rg" --location $located --tags 'CostCenter=Backup' 'Environment=Development'

#Create the storage account

az storage account create --resource-group "$rg" --name "$sa" --sku Standard_LRS --encryption-services blob

#Create the storage container

az storage container create --name "$container" --account-name "$sa"


#set the storage account key variable

accountKey=$(az storage account keys list --resource-group "$rg" --account-name "$sa" --query '[0].value' -o tsv)


#Set the end date for the sas key for the container

end=`date -u -d "2 years" '+%Y-%m-%dT%H:%MZ'`


#generate the sas key for the storage container that will hold the state file

sas=$(az storage container generate-sas -n "$container" --account-key "$accountKey" --account-name "$sa" --https-only --permissions dlrw --expiry "$end" -o tsv)

echo "Resource Group: $rg"
echo "Storage Account: $sa"
echo "Container name: $container"
echo "key can be any name ending with .tfstate"
}
