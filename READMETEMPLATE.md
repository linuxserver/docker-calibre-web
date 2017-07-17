[linuxserverurl]: https://linuxserver.io
[forumurl]: https://forum.linuxserver.io
[ircurl]: https://www.linuxserver.io/irc/
[podcasturl]: https://www.linuxserver.io/podcast/
[appurl]: https://github.com/janeczku/calibre-web
[hub]: https://hub.docker.com/r/linuxserver/calibre-web/

[![linuxserver.io](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/linuxserver_medium.png)][linuxserverurl]

The [LinuxServer.io][linuxserverurl] team brings you another container release featuring easy user mapping and community support. Find us for support at:
* [forum.linuxserver.io][forumurl]
* [IRC][ircurl] on freenode at `#linuxserver.io`
* [Podcast][podcasturl] covers everything to do with getting the most from your Linux Server plus a focus on all things Docker and containerisation!

# linuxserver/calibre-web
[![](https://images.microbadger.com/badges/version/linuxserver/calibre-web.svg)](https://microbadger.com/images/linuxserver/calibre-web "Get your own version badge on microbadger.com")[![](https://images.microbadger.com/badges/image/linuxserver/calibre-web.svg)](https://microbadger.com/images/linuxserver/calibre-web "Get your own image badge on microbadger.com")[![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/calibre-web.svg)][hub][![Docker Stars](https://img.shields.io/docker/stars/linuxserver/calibre-web.svg)][hub][![Build Status](https://ci.linuxserver.io/buildStatus/icon?job=Docker-Builders/x86-64/x86-64-calibre-web)](https://ci.linuxserver.io/job/Docker-Builders/job/x86-64/job/x86-64-calibre-web/)

[Calibre-Web](https://github.com/janeczku/calibre-web) is a web app providing a clean interface for browsing, reading and downloading eBooks using an existing Calibre database.   It is also possible to integrate google drive and edit metadata and your calibre library through the app itself.

This software is a fork of library and licensed under the GPL v3 License.

[![Calibre-Web](https://raw.githubusercontent.com/linuxserver/docker-templates/master/linuxserver.io/img/calibre-web-icon.png)][appurl]

## Usage

```
docker create \
  --name=calibre-web \
  -v <path to data>:/config \
  -v <path to calibre library>:/books \
  -e PGID=<gid> -e PUID=<uid>  \
  -p 8083:8083 \
  linuxserver/calibre-web
```

## Parameters

`The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side. 
For example with a port -p external:internal - what this shows is the port mapping from internal to external of the container.
So -p 8080:80 would expose port 80 from inside the container to be accessible from the host's IP on port 8080
http://192.168.x.x:8080 would show you what's running INSIDE the container on port 80.`



* `-p 8083` - calibre-web gui port
* `-v /config` - where calibre-web stores it's database
* `-v /books` - where your calibre database is located
* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation

It is based on alpine linux with s6 overlay, for shell access whilst the container is running do `docker exec -it calibre-web /bin/bash`.

### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" ™.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

## Setting up the application

Webui can be found at `http://<your-ip>:8083`

On the initial setup screen, enter `/books` as your calibre library location.

**Default admin login:**
*Username:* admin
*Password:* admin123

To reverse proxy with our Letsencrypt docker container use the following location block:
```	
        location /calibre-web {
                proxy_pass              http://<your-ip>:8083;
                proxy_set_header        Host            $http_host;
                proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header        X-Scheme        $scheme;
                proxy_set_header        X-Script-Name   /calibre-web;
        }
```
## Kindlegen

To use the on-the-fly epub to mobi conversion your linux kernel must have IA32 emulation support and you must be using an x86 processor, not ARM.  Download kindlegen for linux and unpack the file called kindlegen into /config.

In the webui on the `about` screen if you see `Excecution permissions missing` then your kernel doesn't support 32 bit binaries and your **only** option is to recompile your kernel with IA32 support as Amazon do not produce a 64bit binary nor publish the source code for kindlegen.

## Info

* Shell access whilst the container is running: `docker exec -it calibre-web /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f calibre-web`

* container version number 

`docker inspect -f '{{ index .Config.Labels "build_version" }}' calibre-web`

* image version number

`docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/calibre-web`

## Versions

+ **17.07.17:** Initial release
