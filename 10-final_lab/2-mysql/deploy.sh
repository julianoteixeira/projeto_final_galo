#!/bin/bash
cd 10-final_lab/2-mysql/0-terraform
# cd 0-terraform
terraform init
terraform apply -auto-approve

echo  "Aguardando a criação das maquinas ..."
sleep 5

ID_M1=$(terraform output | grep 'ec2-g4-mysql 1 -' | awk '{print $4;exit}')
ID_M1_DNS=$(terraform output | grep 'ec2-g4-mysql 1 -' | awk '{print $9;exit}' | cut -b 8-)

ID_M2=$(terraform output | grep 'ec2-g4-mysql 2 -' | awk '{print $4;exit}')
ID_M2_DNS=$(terraform output | grep 'ec2-g4-mysql 2 -' | awk '{print $9;exit}' | cut -b 8-)

ID_M3=$(terraform output | grep 'ec2-g4-mysql 3 -' | awk '{print $4;exit}')
ID_M3_DNS=$(terraform output | grep 'ec2-g4-mysql 3 -' | awk '{print $9;exit}' | cut -b 8-)

echo "
[ec2-ec2-m1]
$ID_M1_DNS
[ec2-ec2-m2]
$ID_M2_DNS
[ec2-ec2-m3]
$ID_M3_DNS
" > ../1-ansible/hosts

# cd 10-final_lab/01-pipeline_infra/2-mysql/1-ansible
cd ../1-ansible
ANSIBLE_OUT=$(ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i hosts provisionar.yml -u ubuntu --private-key ~/.ssh/id_rsa)
echo "ANSIBLE OUT : " $ANSIBLE_OUT
