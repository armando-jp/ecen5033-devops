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


