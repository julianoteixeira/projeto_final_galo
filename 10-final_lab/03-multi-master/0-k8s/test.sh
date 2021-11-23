#!/bin/bash
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i hosts test.yml -u ubuntu --private-key ~/.ssh/id_rsa