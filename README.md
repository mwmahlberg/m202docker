#M202 docker image
"mwmahlberg/m202" is a [Docker image][docker] for [MongoDB University][university]'s excellent class "[M202: MongoDB Advanced Deployment and Operations][m202]".

It is equally useful for the equally excellent class "[M102: MongoDB for DBAs][m102]".

The image holds the current MongoDB release plus the super useful [mtools][mtools] by Thomas Rückstieß.
Additionally, the [mongo-edu][medu] video download helper script by Przemyslaw Pluta was integrated.

I created this docker image after I noticed that some people have problems running the software required in the various classes of the MongoDB university.

##Installation
###Linux

All you need is a current Linux distribution which offers Docker as a package.

There are installation [instructions available for a variety of Linux flavors][dockerLinux] on the Docker homepage.

Please follow the installation instructions for your respective Linux distribution.

###OSX

Docker requires Linux. In order to use Docker on OSX, we need to install a virtual machine which runs Linux and provides the Docker software.

Thanks to the [Boot2Docker][boot2docker] project, doing this is as easy as installing a normal software package on OSX.
 
Please follow the [Docker installation instructions for OSX][dockerOSX].

###Windows

For Windows, the same as for OSX applies.

Please follow the [Docker installation instructions for Windows][dockerWin].

##Installation of "mwmahlberg/m202docker"
Once you have docker running, the installation of the image is actually pretty easy.

###Making data available to the image.
#### Linux
In order to make data available to the image, you have to mount a host volume to the docker image. you do this by issuing

    docker run -i -t -v <HOSTDIRECTORY>:/mnt mwmahlberg/m202docker

This would make all files and directories in `<HOSTDIRECTORY>` available to the directory `/mnt` in the running image.
    
I would suggest to create a folder in your home directory for all the data of the MongoDB classes and use this as `<HOSTDIRECTORY>`. For example
    
    mkdir ~/m202
    docker run -i -t -v ~/m202:/mnt mwmahlberg/m202docker
    
#### OSX & Windows
Making data available to the image is slightly more complicated under OSX than it is under Linux. The good news is that once you have set it up it is easy to use.

##### Create a data only container

We need to have a persistent storage. We achieve that by installing a docker container, start it and have it exit immediately.

    docker run -v /mnt --name m202data busybox true

Unless you remove the exited container explicitly, the data written to the volume `/mnt` is persisted.

##### Install and Run "svendowideit/samba"

In order to make the volume of the data only container accessible, we need to use another container. We use "svendowideit/samba" to do so.

    docker run --rm -v /usr/local/bin/docker:/docker -v /var/run/docker.sock:/docker.sock svendowideit/samba m202data    

This command installs and runs the container, connects to the volume of the data only container and exposes it via Windows sharing.
We use Windows sharing because it is supported by both Windows and OSX.

Please follow the instructions shown after the image is started to connect to the volume.

**Note: You need to start this container every time you (re)start boot2docker**

###Running the image

Once you have set up everything, running the image is as easy as

    docker run -it --volumes-from m202data mwmahlberg/m202docker:latest

After issuing this command you will get a new prompt and you are inside the container!

## Notes

 * Please keep in mind that you only have one console per docker container. So when you start a `mongod` you always need to provide the `--logpath` and the `--fork` option.
 * In case you have any suggestion, found a bug or would like to comment, it would be really appreciated!

## Links

 * [Project on DockerHub][ppdocker]
 * [Project on GitHub][ppgithub]
 * [Issuetracker][issuetracker]


[docker]: https://www.docker.com/whatisdocker/ "\"What is Docker?\" on docker.com"
[mtools]: https://github.com/rueckstiess/mtools/blob/master/README.md "mtools README on github.com"
[university]: https://university.mongodb.com "Homepage of the MongoDB University"
[m202]: https://university.mongodb.com/courses/10gen/M202/2014_September/about "\"About M202\" on university.mongodb.com"
[m102]: https://university.mongodb.com/courses/10gen/M102/2014_September/about "\"About M102\" on university.mongodb.com"
[medu]: https://github.com/przemyslawpluta/mongo-edu "Project page of mongo-edu on github.com"
[boot2docker]: http://boot2docker.io "Homepage of Boot2Docker"
[dockerLinux]: http://docs.docker.com/installation/ "Docker installation instrcutions overview"
[dockerOSX]: http://docs.docker.com/installation/mac/ "Docker installation instructions for OSX"
[dockerWin]: http://docs.docker.com/installation/windows/ "Docker installation intrcutions for Windows"
[ppdocker]: https://registry.hub.docker.com/u/mwmahlberg/m202docker/
[ppgithub]: https://github.com/mwmahlberg/m202docker
[issuetracker]: https://github.com/mwmahlberg/m202docker/issues?q=is%3Aopen+is%3Aissue