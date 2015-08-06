FROM ubuntu:14.04
RUN apt-get update && apt-get install -y python-dev python-pip telnet;\
    pip install buildbot-slave==0.8.12; apt-get install -y git pkg-config curl
RUN useradd -r -d /data/buildbot buildbot;\
    chown -R buildbot:buildbot /data
USER buildbot
ADD run.sh run.sh
CMD ["bash", "./run.sh"]
