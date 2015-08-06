# Latent Slave Queuing Bug Example

This repository provides an example of a bug in the Buildbot code
at 0.8.12 where a LatentBuildSlave fails to start when multiple
builds are scheduled in parallel.

## To Replicate

- Install Docker on your system
- Run `./run.sh [--keeplaive]`

This script builds a docker image "bb-master" with
the correct configuration to start a Buildbot master
instance and another image "bb-builder" to start a docker builder.

It then starts a Buildbot master container, configured with the
right permissions for that container to start future containers.

Finally it submits jobs using the `buildbot submitchange` command.
These should result a build that runs `sleep 10`. The expectation
is that Buildbot either runs all jobs on arrival or runs jobs
sequentially.

However Buildbot will submit the first job and not any others.

After running, the `logs` directory will contain some debugging
information.

Note: supplying the `--keepalive` flag will keep the `bb-master`
container running.  You will need to run `docker stop bb-master;
docker rm bb-master` afterwards.
