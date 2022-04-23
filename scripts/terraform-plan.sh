#!/bin/bash
source ./scripts/fetch_secrets.sh
echo "client_id $ARM_CLIENT_ID"

terraform plan