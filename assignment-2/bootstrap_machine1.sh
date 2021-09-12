#!/usr/bin/env bash

# This script is used by vagrant during machine provisioning.

# Description:
# This bootstrap shell script configures the administrator (adm) machine
# ssh keys with the client machine, machineX.
# This script also copies the hosts file (needed for ansible) and 
# copies the ansible playbook to the adm machine.
# Finally, this script runs the ansible playbook.

# do update
echo "Running apt-get update"
sudo apt-get update

# install docker
echo "Installing docker.io"
yes | sudo apt install docker.io

# fix docker permissions
sudo groupadd docker
sudo usermod -aG docker ${USER}

# install docker compose
echo "Installing docker compose"
yes | sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# start docker service
sudo service docker start

# run docker compose
echo "Running docker compose"
cd /vagrant/
docker-compose up