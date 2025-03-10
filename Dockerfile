FROM woahbase/alpine-php:8.2.27

LABEL maintainer="hello@thomascenni.com"
LABEL version="v1.6.2"

ARG VERSION="v1.6.2"
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
        php82-ctype \
        php82-bcmath \
        php82-dom \
        php82-gd \
    	php82-mysqli \
    	php82-mysqlnd \
    	php82-openssl \
    	php82-pdo_mysql \
    	php82-fileinfo \
    	php82-posix \
    	php82-session \
    	php82-tokenizer \
    	php82-xml \
    	php82-zip \
    	php82-zlib \
        php82-exif \
        php82-simplexml \
        php82-xmlreader \
        php82-xmlwriter \
        php82-gmp \
    && mkdir -p /opt/invoiceplane \
    && echo "InvoicePlane version: ${VERSION}" > /opt/invoiceplane/version \
    && curl -o ${INVOICEPLANE_SRC} -SL "https://github.com/InvoicePlane/InvoicePlane/releases/download/${VERSION}/${VERSION}.zip" \    
    && unzip -qt ${INVOICEPLANE_SRC} \
    && rm -rf /var/cache/apk/* /tmp/*
# add local files
COPY root/ /
# ports, volumes etc from php
# ENTRYPOINT ["/init"]