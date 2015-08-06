#!/bin/bash
DIR="$( cd "$( dirname "$0" )" && pwd )"

docker build -t bb-master ${DIR}/bb-master/.
docker build -t bb-builder ${DIR}/bb-builder/.

pushd ${DIR}/bb-master
./docker_run.sh &
sleep 10
echo "TODO: need to call buildbot sendchange to start builds."
