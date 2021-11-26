#!/bin/bash
cd 10-final_lab/03-multi-master/0-k8s/2-ansible/01-k8s-install-masters_e_workers
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i hosts test.yml -u ubuntu --private-key ~/.ssh/id_rsa
