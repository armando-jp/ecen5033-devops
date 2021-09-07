#!/usr/bin/env bash

MACHINEX_IP='192.168.35.21'
MACHINEX_USER='vagrant'
MACHINEX_PASS='vagrant'
SSH_KEY_PATH='/home/vagrant/.ssh/id_cli'

PLAYBOOK_NAME='hw1.yml'

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

# copy the hosts file to the /home/vagrant directory
cp /vagrant/hosts /home/vagrant

# copy the playbook to the /home/vagrant directory
cp /vagrant/$PLAYBOOK_NAME /home/vagrant

# run the ansible playbook 
ansible-playbook -i hosts $PLAYBOOK_NAME
