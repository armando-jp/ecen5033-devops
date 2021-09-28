#!/usr/bin/env bash

# modify the server app.
sed -i 's/V2/V3/g' ./pyapp/server.py

# modify the nginx-conf.d/server.conf file
sed -i 's/GREEN/BLUE/g' ./nginx-conf.d/server.conf

# build new server app image
docker build -t assign3_server .

# launch a new container with the updated server app
docker run \
    --name python_server-BLUE \
    --net myNet \
    -d \
    assign3_server

# validate that the configuration is correct and that the app
# is reachable.
docker run \
    --rm \
    -v $(pwd)/nginx-confd:/etc/nginx/conf.d \
    --net=myNet \
    nginx:1.21.3 \
    nginx -t\

# if process is sucessful, send the nginx container a SIGHUP signal
# It will re-read the configuration and restart itself w/o dropping
# any requests.
docker kill -s HUP nginx

# GREEN environment is no longer needed so we remove it
docker stop python_server-GREEN
docker rm python_server-GREEN