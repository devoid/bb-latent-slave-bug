#!/bin/bash
DIR="$( cd "$( dirname "$0" )" && pwd )"

mkdir ${DIR}/db
buildbot create-master ${DIR}; buildbot upgrade-master ${DIR}
/usr/local/bin/twistd --nodaemon --no_save -y buildbot.tac
