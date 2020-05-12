FROM php:7.3-cli-alpine

##<alpine>##
RUN apk --no-cache add \
        curl \
        git \
# For composer
        unzip
##</alpine>##

# https://github.com/mlocati/docker-php-extension-installer
COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/bin/

RUN install-php-extensions apcu \
        bcmath \
        gd \
        grpc \
        imagick  \
        intl  \
        memcached \
        mongodb \
        opcache \
##<opencensus>##
        opencensus \
##</opencensus>##
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
RUN pecl install -o -f xdebug \
    && rm -rf /tmp/pear
##</xdebug>##

RUN mkdir -p /opt/workspace
WORKDIR /opt/workspace
