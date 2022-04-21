export SUBSCRIPTION_ID="fc8171ee-10a5-4635-8fd1-0c45800663f1"

az login --identity --allow-no-subscriptions --output none

export client_id=`az keyvault secret show --name sp-tf-id --vault-name diplomado-devops-akv | jq -r .value`
export client_secret=`az keyvault secret show --name sp-tf-secret --vault-name diplomado-devops-akv | jq -r .value`

echo "client_id $client_id"