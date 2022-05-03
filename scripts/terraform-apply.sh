#!/bin/bash
source ./scripts/fetch-secrets.sh

cd ./terraform && terraform apply -auto-approve