#!/bin/bash

echo "Executando os testes das ferramentas ..."

cd 10-final_lab/02-deploy-infra-img-java-app/ansible
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i hosts teste.yml -u ubuntu --private-key ~/.ssh/id_rsa
