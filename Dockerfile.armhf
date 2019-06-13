FROM lsiobase/ubuntu:arm32v7-bionic

# set version label
ARG BUILD_DATE
ARG VERSION
ARG CALIBREWEB_RELEASE
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="chbmb"

RUN \
 echo "**** install build packages ****" && \
 apt-get update && \
 apt-get install -y \
	g++ \
	gcc \
	git \
	libffi-dev \
	libjpeg-dev \
	libxml2-dev \
	libxslt1-dev \
	python-pip \
	zlib1g-dev && \
 echo "**** install runtime packages ****" && \
 apt-get install -y \
	imagemagick \
	python-minimal \
	unrar && \
 echo "**** install calibre-web ****" && \
 if [ -z ${CALIBREWEB_RELEASE+x} ]; then \
	CALIBREWEB_RELEASE=$(curl -sX GET "https://api.github.com/repos/janeczku/calibre-web/releases/latest" \
	| awk '/tag_name/{print $4;exit}' FS='[""]'); \
 fi && \
 curl -o \
 /tmp/calibre-web.tar.gz -L \
	https://github.com/janeczku/calibre-web/archive/${CALIBREWEB_RELEASE}.tar.gz && \
 mkdir -p \
	/app/calibre-web && \
 tar xf \
 /tmp/calibre-web.tar.gz -C \
	/app/calibre-web --strip-components=1 && \
 cd /app/calibre-web && \
 pip install --no-cache-dir -U -r \
	requirements.txt && \
 pip install --no-cache-dir -U -r \
	optional-requirements.txt && \
 echo "**** cleanup ****" && \
 apt-get -y purge \
	g++ \
	gcc \
	git \
	libffi-dev \
	libjpeg-dev \
	libxml2-dev \
	libxslt1-dev \
	python-pip \
	zlib1g-dev && \
 apt-get -y autoremove && \
 rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/*

# add local files
COPY root/ /

# ports and volumes
EXPOSE 8083
VOLUME /books /config
