FROM ghcr.io/linuxserver/baseimage-ubuntu:focal

# set version label
ARG BUILD_DATE
ARG VERSION
ARG CALIBREWEB_COMMIT
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="chbmb"

RUN \
 echo "**** install build packages ****" && \
 apt-get update && \
 apt-get install -y \
	git \
	libldap2-dev \
	libsasl2-dev \
	python3-pip && \
 echo "**** install runtime packages ****" && \
 apt-get install -y \
	imagemagick \
	libnss3 \
	libxcomposite1 \
	libxi6 \
	libxslt1.1 \
	libldap-2.4-2 \
	libsasl2-2 \
	libxrandr2 \
	python3-minimal \
	python3-pkg-resources \
	unrar && \
 echo "**** install calibre-web ****" && \
 if [ -z ${CALIBREWEB_COMMIT+x} ]; then \
	CALIBREWEB_COMMIT=$(curl -sX GET "https://api.github.com/repos/janeczku/calibre-web/commits/master" \
	| awk '/sha/{print $4;exit}' FS='[""]'); \
 fi && \
 curl -o \
 /tmp/calibre-web.tar.gz -L \
	"https://github.com/janeczku/calibre-web/archive/${CALIBREWEB_COMMIT}.tar.gz" && \
 mkdir -p \
	/app/calibre-web && \
 tar xf \
 /tmp/calibre-web.tar.gz -C \
	/app/calibre-web --strip-components=1 && \
 cd /app/calibre-web && \
 pip3 install --no-cache-dir -U \
	pip && \
 pip install --no-cache-dir -U -r \
	requirements.txt -r \
	optional-requirements.txt && \
 echo "***install kepubify" && \
 if [ -z ${KEPUBIFY_RELEASE+x} ]; then \
    KEPUBIFY_RELEASE=$(curl -sX GET "https://api.github.com/repos/pgaskin/kepubify/releases/latest" \
    | awk '/tag_name/{print $4;exit}' FS='[""]'); \
 fi && \
 curl -o \
 /usr/bin/kepubify -L \
	https://github.com/pgaskin/kepubify/releases/download/${KEPUBIFY_RELEASE}/kepubify-linux-64bit && \
 echo "**** cleanup ****" && \
 apt-get -y purge \
	git \
	libldap2-dev \
	libsasl2-dev \
	python3-pip && \
 apt-get -y autoremove && \
 rm -rf \
	/tmp/* \
	/var/lib/apt/lists/* \
	/var/tmp/* \
	/root/.cache

# add local files
COPY root/ /

# ports and volumes
EXPOSE 8083
VOLUME /config
