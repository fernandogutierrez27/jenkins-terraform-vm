#!/bin/bash
export ANSIBLE_HOST_KEY_CHECKING=False

az login --identity --allow-no-subscriptions --output none

# Leer IPs desde az-cli y generar archivo ansible-hosts
> ansible-hosts #clean ansible-hosts
> /var/jenkins_home/.ssh/known_hosts
# TODO: resolver como obtener valor de terraform-vms-rg
az vm list -g terraform-vms-rg --query "[].privateIps" -d | jq -c '.[]' | while read object; do
    echo "$object" >> ansible-hosts
done

# Leer private key desde AKV
export ssh_key=`az keyvault secret show --name ansible-vm-ssh --vault-name diplomado-devops-akv | jq -r .value`

# Generar archivo temporal
tempkeyfile=$(mktemp)
chmod 600 "$tempkeyfile"
echo "$ssh_key" > $tempkeyfile

# Ejecutar Ansible
ansible all -m ping -i ./ansible-hosts -u ansibleadmin --key-file $tempkeyfile
ansible-playbook ./ansible/playbook.yaml -i ./ansible-hosts -u ansibleadmin --key-file $tempkeyfile
# ssh -i $tempkeyfile ansibleadmin@10.0.1.4