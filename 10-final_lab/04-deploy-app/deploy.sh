#!/bin/bash

cd 10-final_lab/04-deploy-app
ANSIBLE_OUT=$(ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i hosts provisionar.yml -u ubuntu --private-key ~/.ssh/id_rsa)
echo $ANSIBLE_OUT
