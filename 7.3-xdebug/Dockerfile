FROM php:7.3-cli

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
# for memcached
        libmemcached-dev \
        libssl-dev \
# for imagic
        libmagickwand-dev \
    && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install intl
RUN docker-php-ext-install mbstring
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install pcntl
RUN docker-php-ext-install xsl
RUN docker-php-ext-install zip
RUN docker-php-ext-install soap
RUN docker-php-ext-install bcmath

RUN pecl install -o -f redis \
    && rm -rf /tmp/pear
RUN docker-php-ext-enable redis

RUN pecl install -o -f memcached \
    && rm -rf /tmp/pear
RUN docker-php-ext-enable memcached

RUN pecl install -o -f mongodb \
    && rm -rf /tmp/pear
RUN docker-php-ext-enable mongodb

RUN pecl install -o -f imagick \
    && rm -rf /tmp/pear
RUN docker-php-ext-enable imagick

RUN pecl install -o -f apcu \
    && rm -rf /tmp/pear
RUN docker-php-ext-enable --ini-name 0-apcu.ini apcu

##<apcu_bc>##
RUN pecl install -o -f apcu_bc \
    && rm -rf /tmp/pear
RUN docker-php-ext-enable --ini-name 1-apc.ini apc
##</apcu_bc>##

RUN echo "date.timezone=UTC" > /usr/local/etc/php/conf.d/timezone.ini
RUN echo "memory_limit=512M" > /usr/local/etc/php/conf.d/memory.ini

RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

RUN pecl install -o -f xdebug \
    && rm -rf /tmp/pear
##<xdebug>##
RUN docker-php-ext-enable xdebug
##</xdebug>##

RUN mkdir -p /opt/workspace
WORKDIR /opt/workspace
