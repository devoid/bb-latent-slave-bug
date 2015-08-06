# Latant Slave Queuing Bug Example

Note: This is a work in progress. Currently having issues start
the master--it complains with a supurious "you need to run upgrade-master"
even after that has been done.

This repository provides an example of a bug in the Buildbot code
at 0.8.12 where a LatentBuildSlave fails to start when multiple
builds are scheduled in parallel.

## To Replicate

- Install Docker on your system
- Run ./run.sh

