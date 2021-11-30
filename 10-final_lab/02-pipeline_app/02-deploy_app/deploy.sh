#!/bin/bash
echo "
[database]
$DEV
$STAGE
$PROD
[kubernets-master]
$K8sMaster
[mysql]
$USER
$PASSWORD
$DATABASE
" > 10-final_lab/02-pipeline_app/02-deploy_app/hosts

cd 10-final_lab/02-pipeline_app/02-deploy_app

ANSIBLE_OUT=$(ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i hosts provisionar.yml -u ubuntu --private-key ~/.ssh/id_rsa)
echo "ANSIBLE OUT : " $ANSIBLE_OUT