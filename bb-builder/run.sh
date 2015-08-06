#!/bin/bash
buildslave create-slave . buildbot $SLAVE_NAME $SLAVE_PASS
buildslave start --nodaemon
