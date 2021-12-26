#!/bin/bash

APPLICATION_PORT=8080
SIDECAR_PORT=8081

# using nginx as an example of untouched application container
APPLICATION_CONTAINER_ID=$(docker run --rm -d -p $APPLICATION_PORT:80 --name application nginx:latest)

# launching topz container as a sidecar, sharing the PID namespace of the application container
docker run --rm -d \
    --pid=container:$APPLICATION_CONTAINER_ID \
    -p $SIDECAR_PORT:8080 \
    --name sidecar \
    brendanburns/topz:db0fa58 \
    /server --addr=0.0.0.0:8080 \
    > /dev/null

echo "Calling /topz on sidecar container to check processes running on application container..."
curl localhost:$SIDECAR_PORT/topz

echo "Stopping containers..."
docker stop application sidecar > /dev/null