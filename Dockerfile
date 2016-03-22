# m202docker
#
# VERSION	v0.1
FROM ubuntu:14.04
MAINTAINER Markus W Mahlberg "markus.mahlberg@me.com"
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 && \
    echo 'deb http://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.0 multiverse' > /etc/apt/sources.list.d/mongodb.list
RUN DEBIAN_FRONTEND="noninteractive" apt-get update
RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install python-dev python-pymongo python-pip mongodb-org python-numpy npm && apt-get clean
RUN ln -s /usr/bin/nodejs /usr/bin/node && npm install mongo-edu -g
RUN install -d -m 0777 /data/db
RUN pip install mtools
