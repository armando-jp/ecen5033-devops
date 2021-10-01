#### Demo
1. `vagrant up`
2. `vagrant ssh`
3. `cd /vagrant/`
4. `docker-compose up`
5. Open a new terminal for following commands.
6. `vagrant ssh`
6. `cd /vagrant/`
7. `curl http://localhost:8080` (should see: The application works. Build V1)
8. `./upgrade-1.sh`
9. `curl http://localhost:8080` (should see: The application works. Build V2)
10. `./upgrade-2.sh`
11. `curl http://localhost:8080` (should see: The application works. Build V3)

#### Teardown
1. `./cleanup.sh`
2. `exit` (if inside vagrant shell)
3. `vagrant halt` 