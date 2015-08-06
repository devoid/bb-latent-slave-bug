#!/bin/bash
DIR="$( cd "$( dirname "$0" )" && pwd )"
LOGS=${DIR}/logs

mkdir -p ${LOGS}

echo "Building docker images for master and slave. This may take a bit..."
docker build -t bb-master ${DIR}/bb-master/. >${LOGS}/docker-build-bb-master.log 2>&1
docker build -t bb-builder ${DIR}/bb-builder/. >${LOGS}/docker-build-bb-builder.log 2>&1

echo "Starting buildbot master..."
${DIR}/bb-master/docker_run.sh &
echo "Waiting 10 seconds for master to start up..."
sleep 10

auth="buildbot:password123"
master="localhost:9999"
for i in {1..3}; do
    echo "Triggering build $i ..."
    docker exec bb-master buildbot sendchange \
        -m $master -a $auth -W "devoid" -b "master" -c "comment-$i"
done

# Jobs sleep for 10 seconds
WAIT=40
echo "Jobs should take 10 seconds..."
echo "Waiting $WAIT seconds for all jobs..."
sleep $WAIT
echo "Database state after waiting $WAIT seconds..."
SQLITE_CMD='sqlite3 -header -echo -column ./db/state.sqlite'
docker exec bb-master $SQLITE_CMD 'select * from buildrequests' > ${LOGS}/bb-db-buildrequests.txt
docker exec bb-master $SQLITE_CMD 'select * from buildrequest_claims' > ${LOGS}/bb-db-buildrequest_cliams.txt
docker exec bb-master $SQLITE_CMD 'select * from builds' > ${LOGS}/bb-db-builds.txt
docker exec bb-master cat ./db/state.sqlite > ${LOGS}/state.sqlite
cat ${LOGS}/*.txt
echo "Saving twistd.log to ${LOGS}/bb-master-twistd.log"
docker exec bb-master cat twistd.log > ${LOGS}/bb-master-twistd.log

if [[ "$1" -ne "--keepalive" ]]; then 
    echo "Shutting down bb-master container, use --keepalive flag to keep slave up."
    docker stop bb-master; docker rm bb-master
fi
echo "Other log files and database tables available in ${LOGS}"
