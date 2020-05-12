FROM php:5.5-cli

RUN apt-get update && apt-get install -y --no-install-recommends \
        curl \
        git \
# For composer
        unzip \
    && rm -rf /var/lib/apt/lists/*

# https://github.com/mlocati/docker-php-extension-installer
#COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/bin/
COPY install-php-extensions /usr/bin/

RUN install-php-extensions apcu \
        bcmath \
        gd \
#        grpc  \
        imagick  \
        intl  \
        mcrypt \
        memcached \
        mongodb \
        opcache \
        opencensus \
        pcntl \
        pdo_mysql \
        pdo_pgsql \
        protobuf \
        redis \
        soap \
        sockets \
        xsl \
        zip

RUN echo "date.timezone=UTC" > /usr/local/etc/php/conf.d/timezone.ini
RUN echo "memory_limit=512M" > /usr/local/etc/php/conf.d/memory.ini

RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

##<xdebug>##
RUN pecl install -o -f xdebug-2.5.5 \
    && rm -rf /tmp/pear
##</xdebug>##

RUN mkdir -p /opt/workspace
WORKDIR /opt/workspace
