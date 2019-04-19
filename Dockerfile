# Based on: https://github.com/laradock/php-fpm/blob/master/Dockerfile-73
# and https://github.com/laradock/laradock/blob/master/php-fpm/Dockerfile
FROM php:7.2-fpm as php-fpm
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
    pecl channel-update pecl.php.net && \
    apt-get install -y --no-install-recommends \
        apt-utils \
        curl \
        libmemcached-dev \
        libz-dev \
        libjpeg-dev \
        libpng-dev \
        libfreetype6-dev \
        libssl-dev \
        libmcrypt-dev \
        libzip-dev zip unzip && \
    rm -rf /var/lib/apt/lists/*
RUN docker-php-ext-install pdo_mysql && \
    docker-php-ext-configure gd \
        --with-jpeg-dir=/usr/lib \
        --with-freetype-dir=/usr/include/freetype2 && \
    docker-php-ext-install gd && \
    docker-php-ext-configure zip --with-libzip && \
    docker-php-ext-install zip
