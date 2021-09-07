#!/usr/bin/env bash

MACHINEX_IP='192.168.35.21'
MACHINEX_USER='vagrant'
MACHINEX_PASS='vagrant'
SSH_KEY_PATH='/home/vagrant/.ssh/id_cli'

# ANSIBLE_HOST_PATH='/etc/ansible/hosts'
read -r -d '' ANSIBLE_HOST_INFO << EOM
[targets]
192.168.35.21

[all:vars]
ansible_user=vagrant
ansible_ssh_pass=vagrant

ansible_ssh_host=192.168.35.21
ansible_ssh_private_key_file=/home/vagrant/.ssh
EOM

# do update
echo "Running apt-get update"
sudo apt-get update

# setup ansible
echo "Running add-apt-repository ppa:ansible/ansible-2.10"
sudo add-apt-repository ppa:ansible/ansible-2.10
yes | sudo apt install ansible

# generate ssh key
echo "Running ssh-keygen"
ssh-keygen -t rsa -N "" -f $SSH_KEY_PATH

# copy the ssh id to machineX
sshpass -p $MACHINEX_PASS ssh-copy-id -o StrictHostKeyChecking=no -i $SSH_KEY_PATH $MACHINEX_USER@$MACHINEX_IP

# # add lines to ansible host file
# sudo chmod 666 /etc/ansible/hosts
# echo "$ANSIBLE_HOST_INFO" >> $ANSIBLE_HOST_PATH

# create hosts file in home directory
echo "$ANSIBLE_HOST_INFO" >> /home/vagrant/hosts