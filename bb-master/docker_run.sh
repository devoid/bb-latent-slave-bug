#!/bin/bash
DIR="$( cd "$( dirname "$0" )" && pwd )"

NAME="bb-master"
IMG="bb-master:latest"

docker run --name $NAME -e DOCKER_CONTAINER_NAME=$NAME \
    --cap-add=ALL --restart=always --detach=true \
    -v $DIR/master.cfg:/data/buildbot/master.cfg \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -p 80:8010 $IMG $@
