FROM woahbase/alpine-php:x86_64

LABEL maintainer="hello@thomascenni.com"
LABEL version="v1.5.11"

ARG VERSION="v1.5.11"
ENV INVOICEPLANE_SRC=/opt/invoiceplane/invoiceplane.zip

ENV IP_URL="http://localhost" \
    DB_HOSTNAME="localhost" \
    DB_USERNAME="invoiceplane" \
    DB_PASSWORD="invoiceplane" \
    DB_DATABASE="invoiceplane" \
    DB_PORT="3306"

ARG PUID=1000
ARG PGID=1000

RUN set -xe \
    && apk add --no-cache --purge -uU \
        curl \
        unzip \
        php7-ctype \
        php7-bcmath \
        php7-dom \
        php7-gd \
    	php7-mysqli \
    	php7-mysqlnd \
    	php7-openssl \
    	php7-pdo_mysql \
    	php7-fileinfo \
    	php7-posix \
    	php7-session \
    	php7-tokenizer \
    	php7-xml \
    	php7-zip \
    	php7-zlib \
        php7-exif \
        php7-simplexml \
        php7-xmlreader \
        php7-xmlwriter \
        php7-gmp \
    && mkdir -p /opt/invoiceplane \
    && echo "InvoicePlane version: ${VERSION}" > /opt/invoiceplane/version \
    && curl -o ${INVOICEPLANE_SRC} -SL "https://github.com/InvoicePlane/InvoicePlane/releases/download/${VERSION}/${VERSION}.zip" \    
    && unzip -qt ${INVOICEPLANE_SRC} \
    && rm -rf /var/cache/apk/* /tmp/*
# add local files
COPY root/ /
# ports, volumes etc from php
# ENTRYPOINT ["/init"]