#!/bin/bash

VERSAO=$(git describe --tags $(git rev-list --tags --max-count=1))

cd 10-final_lab/0-build-kubernetes-ami/0-terraform
RESOURCE_ID=$(terraform output | grep resource_id | awk '{print $2;exit}' | sed -e "s/\",//g")

cd ../2-terraform-ami
terraform init
TF_VAR_versao=$VERSAO TF_VAR_resource_id=$RESOURCE_ID terraform apply -auto-approve
