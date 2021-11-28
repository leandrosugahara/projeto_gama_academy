#!/bin/bash
sleep 10
echo "Validação da aplicação de DEV"
curl http://$K8sMaster:30000

echo "Validação da aplicação de STAGE"
curl http://$K8sMaster:30001

echo "Validação da aplicação de PROD"
curl http://$K8sMaster:30002