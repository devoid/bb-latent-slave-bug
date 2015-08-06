#!/bin/bash
DIR="$( cd "$( dirname "$0" )" && pwd )"

buildbot upgrade-master ${DIR}
/usr/local/bin/twistd --nodaemon --no_save -y buildbot.tac
