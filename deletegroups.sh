#!/bin/bash
createarraysub(){
subscriptions=$(az account subscription list | jq .[].subscriptionId | tr -d '""' > subs.txt)
readarray -t subscription < subs.txt
}

createarrayrg(){
delg=$(az group list | jq .[].name | tr -d '""'  > rg.txt)
readarray -t delg < rg.txt
}

setsub(){
#num=$(wc -l < subs.txt)
num=4
count=$num
while [ $count == 4 ]
do

let count=count
for t in ${subscription["$count"]}
do
echo "This $t should be true"
az account set --subscription "$t"
echo "subscription set"
az account list -o table
listrg
echo "listing the groups"
done
done
}
listrg(){
createarrayrg

num=$(wc -l < rg.txt)
#num=3
count=$num
while [ $count -gt 0 ]
do
let count=count-1
for g in ${delg["$count"]}
do
az group list -o table
#az account list -o table
echo "we are in the group $g"
echo "Also show the subscription $t"


az group show --name "$g"
az group delete --name "$g" -y
#
done
done

}


