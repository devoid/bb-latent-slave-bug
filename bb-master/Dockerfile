FROM ubuntu:14.04
# Install required packages
RUN apt-get update && apt-get install -y python-dev python-pip;\
    apt-get install -y libffi-dev libssl1.0.0 libssl-dev git sudo ssh sqlite3;\
    apt-get install -y docker.io python-openssl python-requests;\
    pip install --upgrade buildbot==0.8.12;\
    pip install --upgrade service-identity docker-py;

WORKDIR /data/buildbot
ADD run.sh run.sh
# Add buildbot user and home directory, create master template
RUN groupmod -g 119 docker;\
    useradd -r -G docker -G users -d /data/buildbot buildbot;\
    chown -R buildbot:buildbot /data/buildbot
USER buildbot
EXPOSE 8010 9989
CMD ["bash", "./run.sh"]
