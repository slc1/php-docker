FROM php:7.3-cli

##<debian>##
RUN apt-get update && apt-get install -y --no-install-recommends \
        curl \
        git \
# For composer
        unzip \
    && rm -rf /var/lib/apt/lists/*
##</debian>##

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

ADD https://getcomposer.org/composer-stable.phar /usr/local/bin/composer
RUN chmod +rx /usr/local/bin/composer
RUN composer global require symfony/flex:"1.6.*" \
    && rm -rf /home/composer/.composer/cache

##<xdebug>##
RUN pecl install -o -f xdebug \
    && rm -rf /tmp/pear
##</xdebug>##

RUN mkdir -p /opt/workspace
WORKDIR /opt/workspace
