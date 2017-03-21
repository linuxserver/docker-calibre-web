[linuxserverurl]: https://linuxserver.io
[forumurl]: https://forum.linuxserver.io
[ircurl]: https://www.linuxserver.io/irc/
[podcasturl]: https://www.linuxserver.io/podcast/
[appurl]: www.example.com
[hub]: https://hub.docker.com/r/example/example/

[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)][linuxserverurl]

The [LinuxServer.io][linuxserverurl] team brings you another container release featuring easy user mapping and community support. Find us for support at:
* [forum.linuxserver.io][forumurl]
* [IRC][ircurl] on freenode at `#linuxserver.io`
* [Podcast][podcasturl] covers everything to do with getting the most from your Linux Server plus a focus on all things Docker and containerisation!

# <image-name>

Provide a short, concise description of the application. No more than two SHORT paragraphs. Link to sources where possible and include an image illustrating your point if necessary. Point users to the original applications website, as that's the best place to get support - not here.

Our Plex container has immaculate docs so follow that if in doubt for layout.

`IMPORTANT, replace all instances of <image-name> with the correct dockerhub repo (ie linuxserver/plex) and <container-name> information (ie, plex)`

## Usage

```
docker create \
  --name=<container-name> \
  -v <path to data>:/config \
  -e PGID=<gid> -e PUID=<uid>  \
  -p 1234:1234 \
  <image-name>
```

## Parameters

`The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side. 
For example with a port -p external:internal - what this shows is the port mapping from internal to external of the container.
So -p 8080:80 would expose port 80 from inside the container to be accessible from the host's IP on port 8080
http://192.168.x.x:8080 would show you what's running INSIDE the container on port 80.`



* `-p 1234` - the port(s)
* `-v /config` - explain what lives here
* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation

It is based on alpine linux with s6 overlay, for shell access whilst the container is running do `docker exec -it <container-name> /bin/bash`.

### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" ™.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

## Setting up the application

Insert a basic user guide here to get a n00b up and running with the software inside the container. DELETE ME


## Info

* Shell access whilst the container is running: `docker exec -it <container-name> /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f <container-name>`

* container version number 

`docker inspect -f '{{ index .Config.Labels "build_version" }}' <container-name>`

* image version number

`docker inspect -f '{{ index .Config.Labels "build_version" }}' <image-name>`

## Versions

+ **dd.MM.yy:** This is the standard Version type now.
