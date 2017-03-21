FROM lsiobase/alpine.nginx:3.5
MAINTAINER sparklyballs

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"

# install build packages
RUN \
 apk add --no-cache --virtual=build-dependencies \
	curl \
	g++ \
	gcc \
	git \
	make \
	python2-dev \
	tar && \

# install runtime packages
 apk add --no-cache \
	py2-lxml \
	py2-pip \
	python2 && \

# install calibre-web
 mkdir -p \
	/app/calibre-web && \
 curl -o \
 /tmp/calibre-web.tar.gz -L \
	https://github.com/janeczku/calibre-web/archive/master.tar.gz && \
 tar xf \
 /tmp/calibre-web.tar.gz -C \
	/app/calibre-web --strip-components=1 && \
 cd /app/calibre-web && \
 pip install --no-cache-dir -U -r \
	requirements.txt && \

# install pip packages
 pip install --no-cache-dir -U \
	gunicorn \
	Wand && \

# cleanup
 apk del --purge \
	build-dependencies && \
 rm -rf \
	/etc/services.d/php-fpm \
	/etc/logrotate.d/php-fpm7 \
	/tmp/*

# add local files
COPY root/ /

# ports and volumes
EXPOSE 80
VOLUME /books /config
