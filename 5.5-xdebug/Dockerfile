FROM php:5.5-cli

RUN apt-get update && apt-get install -y --no-install-recommends \
        curl \
        git \
# For composer mostly
        unzip \
# for intl
        libicu-dev \
# for xsl
        libxslt-dev \
# for zip
        zlib1g-dev \
        libzip-dev \
##<mcrypt>##
# for mcrypt
        libmcrypt-dev \
##</mcrypt>##
# for memcached
        libmemcached-dev \
        libssl-dev \
# for imagic
        libmagickwand-dev \
    && rm -rf /var/lib/apt/lists/*

##<mcrypt>##
RUN docker-php-ext-install mcrypt
##</mcrypt>##
RUN docker-php-ext-install intl
RUN docker-php-ext-install mbstring
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install pcntl
RUN docker-php-ext-install xsl
RUN docker-php-ext-install zip
RUN docker-php-ext-install soap
RUN docker-php-ext-install bcmath

RUN pecl install -o -f redis-2.2.8 \
    && rm -rf /tmp/pear
RUN docker-php-ext-enable redis

RUN pecl install -o -f memcached-2.2.0 \
    && rm -rf /tmp/pear
RUN docker-php-ext-enable memcached

RUN pecl install -o -f mongodb \
    && rm -rf /tmp/pear
RUN docker-php-ext-enable mongodb

RUN pecl install -o -f imagick \
    && rm -rf /tmp/pear
RUN docker-php-ext-enable imagick

RUN pecl install -o -f apcu-4.0.11 \
    && rm -rf /tmp/pear
RUN docker-php-ext-enable --ini-name 0-apcu.ini apcu


RUN echo "date.timezone=UTC" > /usr/local/etc/php/conf.d/timezone.ini
RUN echo "memory_limit=512M" > /usr/local/etc/php/conf.d/memory.ini

RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

RUN pecl install -o -f xdebug-2.5.5 \
    && rm -rf /tmp/pear
##<xdebug>##
RUN docker-php-ext-enable xdebug
##</xdebug>##

RUN mkdir -p /opt/workspace
WORKDIR /opt/workspace
