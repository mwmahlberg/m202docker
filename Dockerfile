# m202docker
#
# VERSION	v0.1
FROM ubuntu:14.04
MAINTAINER Markus W Mahlberg "markus.mahlberg@me.com"
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 && \ 
    echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' > /etc/apt/sources.list.d/mongodb.list
RUN DEBIAN_FRONTEND="noninteractive" apt-get update
RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install python-dev python-pymongo python-pip mongodb-org python-numpy
RUN install -d -m 0777 /data/db
RUN pip install mtools
RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install npm && apt-get clean all
RUN ln -s /usr/bin/nodejs /usr/bin/node && npm install mongo-edu -g && npm cache clean
EXPOSE 27017 27018 27019
VOLUME /mnt