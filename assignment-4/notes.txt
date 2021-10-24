=== INITIALIZATION ===
[initialize vagrant machines, run commands from assignment-4 directory]
1. vagrant up
2. follow steps outlined in k8s_installation_instructions.txt
3. ./copy_files.sh (from host machine)

[set up local registry on all 3 machines]
***MACHINE1***
1. vagrant ssh machine1
2. sudo docker run -d -p 5000:5000 --restart=always --name registry registry:2
3. edit /etc/docker/daemon.json, adding this inside the { } (you’ll need a comma on the current last entry)
"insecure-registries":["192.168.33.10:5000"]
4. sudo service docker restart

***MACHINE2***
1. vagrant ssh machine2
2. sudo docker run -d -p 5000:5000 --restart=always --name registry registry:2
3. edit /etc/docker/daemon.json, adding this inside the { } (you’ll need a comma on the current last entry)
"insecure-registries":["192.168.33.10:5000"]
4. sudo service docker restart

***MACHINE3***
1. vagrant ssh machine3
2. sudo docker run -d -p 5000:5000 --restart=always --name registry registry:2
3. edit /etc/docker/daemon.json, adding this inside the { } (you’ll need a comma on the current last entry)
"insecure-registries":["192.168.33.10:5000"]
4. sudo service docker restart

=== PART 1 ===
[assign labels to nodes]
1. vagrant ssh machine1
2. kubectl label node machine1 machine=machine1 --overwrite
2. kubectl label node machine2 machine=machine2 --overwrite
3. kubectl label node machine3 machine=machine3 --overwrite

[build the nodejs image on machine2]
1. vagrant ssh machine2
2. cd /vagrant_data/nodejs/njsapp/
3. ./build_njsapp.sh

[build the python_client image on machine3]
1. vagrant ssh machine3
2. cd /vagrant_data/python_client
3. ./build_client.sh

[run njsapp replication controller]
1. vagrant ssh machine1
2. cd /vagrant_data/nodejs/
3. kubectl apply -f armando_njsapp-rc.yml

[run njsapp service]
1. vagrant ssh machine1
2. cd /vagrant_data/nodejs/
3. kubectl apply -f armando_njsapp_svc.yml

[run py_client]
1. vagrant ssh machine1
2. cd /vagrant_data/python_client/
3. kubectl apply -f armando_py_client-pod.yml

[validate]
1. vagrant ssh machine1
2. kubectl logs py-client

=== PART 2 ===
[teardown replication controller]
1. vagrant ssh machine1
2. kubectl delete rc njsapp-rc

[create deployment]
1. vagrant ssh machine1
2. cd /vagrant_data/nodejs/
3. kubectl apply -f armando_njsapp-dep.yml

[edit njsapp]
1. vagrant ssh machine2
2. cd /vagrant_data/nodejs/njsapp/
3. vi app.js
4. On line 11, replace "You've hit " with "You've punched "
5. Save changes.

[create new njsapp image]
1. vagrant ssh machine2
2. cd /vagrant_data/nodejs/njsapp/
3. ./build_njsappv2.sh

[modify service file and redeploy]
1. vagrant ssh machine1
2. cd /vagrant_data/nodejs/
3. vi armando_njsapp-dep.yml
4. Edit line 19, append ':v2' at end so it reads: 'image: 192.168.33.10:5000/njsapp:v2'
5. kubectl apply -f armando_njsapp-dep.yml

[validate that update has occured]
1. vagrant ssh machine1
2. kubectl logs py-client

[cleanup]
1. kubectl delete service njsapp-svc
2. kubectl delete pod py-client