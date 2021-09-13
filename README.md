# ECEN 5773-DevOps in the Cloud
## This Github repo containing all homework assignments for ECEN 5773. Assignment files are contained in folders bearing the respective assignemnt name.
  
---
### assignment-1
Creates two VMs using Vagrant called *adm* and *machneX*. During provisioning, Ansible is installed on adm and an SSH key-pair is generated on adm then copied to machineX. Finally, the Ansible playbook *hw1.yml* is copied to adm's home directory and executed. The Ansible playbook targets machineX and installs a terminal version of tetris from [source](https://github.com/taylorconor/tinytetris.git) along with necessary dependencies.

#### Steps to run
1. `git clone` this repo
2. `cd ecen5573-devops/assignemnt-1`
3. `vagrant up`
4. `vagrant ssh machineX`
5. `cd tetris/`
6. `./tinytetris`
---
### assignment-2
Creates a single VM named "machine1", using Vagrant. During provisioning, Docker and Docker Compose are installed. Then, docker-compose is run which will create two containers named **python_server** and **python_client** respectively. python_server runs **server.py** which services math requests received in JSON format from clients. python_client runs **client.py**, which generates math requests in JSON format for the the python_server every 5 seconds.

#### Steps to run
1. `git clone` this repo
2. `cd ecen5573-devops/assignemnt-2`
3. `vagrant up`

