#!/usr/bin/env bash

sudo apt-get update

# Set PasswordAuthentication to YES and restart SSH service
sudo sed -i '0,/PasswordAuthentication no/{s/PasswordAuthentication no/PasswordAuthentication yes/}' /etc/ssh/sshd_config
sudo service ssh restart