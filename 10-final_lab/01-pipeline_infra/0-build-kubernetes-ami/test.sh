#!/bin/bash

echo "Executando os testes das ferramentas ..."

cd 10-final_lab/01-pipeline_infra/0-build-kubernetes-ami/1-ansible
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i hosts teste.yml -u ubuntu --private-key ~/.ssh/id_rsa