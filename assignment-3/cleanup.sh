#!/usr/bin/env bash

# stop and remove the web server container
docker container stop python_server-BLUE
docker container rm python_server-BLUE

# stop and remove nginx, registrator, and etcd services
docker-compose stop
docker-compose down

# reset server source files (revert to V1)
sed -i 's/V3/V1/g' ./pyapp/server.py