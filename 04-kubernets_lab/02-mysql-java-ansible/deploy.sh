#!/bin/bash

ANSIBLE_OUT=$(ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i hosts provisionar.yml -u ubuntu --private-key ~/.ssh/id_rsa)
echo "ANSIBLE OUT : " $ANSIBLE_OUT

## Mac ##
# MYSQL_POD_NAME=$(echo $ANSIBLE_OUT | grep -oE "(mysql-.*? )" )
## Linux ##
MYSQL_POD_NAME=$(echo $ANSIBLE_OUT | grep -oP "(mysql-.*? )" )

echo "POD MYSQL: " $MYSQL_POD_NAME 

echo "Esperando subir os pods ..."
# sleep 300

cat <<EOF > restore-dump-mysql.yml
- hosts: all
  become: yes
  tasks:
    - name: "Create dabatase"
      shell: echo "create database SpringWebYoutube;"| kubectl exec -it $MYSQL_POD_NAME --tty -- mysql -uroot -ppassword_mysql
    
    - name: "Restore dump"
      shell: cat /root/k8s-deploy/1.2-dump-mysql.sql  | kubectl exec -it $MYSQL_POD_NAME --tty -- mysql -uroot -ppassword_mysql SpringWebYoutube
EOF

ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i hosts restore-dump-mysql.yml -u ubuntu --private-key ~/.ssh/id_rsa
