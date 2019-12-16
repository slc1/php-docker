FROM php:5.5-cli

RUN apt-get update && apt-get install -y --no-install-recommends \
        curl \
        git \
# For composer
        unzip \
    && rm -rf /var/lib/apt/lists/*

##<apcu>##
RUN pecl install -o -f apcu-4.0.11 \
    && rm -rf /tmp/pear \
    && docker-php-ext-enable --ini-name 0-apcu.ini apcu \
    && echo "apc.enable_cli=1" >> $PHP_INI_DIR/conf.d/0-apcu.ini
##</apcu>##


##<bcmath>##
RUN docker-php-ext-install -j$(nproc) bcmath
##</bcmath>##

##<gd>##
RUN apt-get update && apt-get install -y --no-install-recommends \
        libfreetype6 \
        libfreetype6-dev \
        libjpeg62-turbo \
        libjpeg62-turbo-dev \
        libpng16-16 \
        libpng-dev \
        libwebp6 \
        libwebp-dev \
        libxpm4 \
        libxpm-dev \
##<php5-7.3>##
    && docker-php-ext-configure gd --with-gd --with-jpeg-dir --with-png-dir --with-zlib-dir --with-xpm-dir --with-freetype-dir --with-webp-dir \
##</php5-7.3>##
    && docker-php-ext-install -j$(nproc) gd \
    && apt-get purge -y --auto-remove libfreetype6-dev libjpeg62-turbo-dev libpng-dev \
    && rm -rf /var/lib/apt/lists/*
##</gd>##

##<grpc>##
RUN apt-get update && apt-get install -y --no-install-recommends \
        zlib1g zlib1g-dev \
    && pecl install -o -f grpc \
    && rm -rf /tmp/pear \
    && docker-php-ext-enable grpc \
    && apt-get purge -y --auto-remove zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*
##</grpc>##

##<imagick>##
RUN apt-get update && apt-get install -y --no-install-recommends \
##<stretch>##
        libmagickwand-6.q16-3 \
##</stretch>##
        libmagickwand-dev \
    && pecl install -o -f imagick \
    && rm -rf /tmp/pear \
    && docker-php-ext-enable imagick \
    && apt-get purge -y --auto-remove libmagickwand-dev \
    && rm -rf /var/lib/apt/lists/*
##</imagick>##

##<intl>##
RUN apt-get update && apt-get install -y --no-install-recommends \
##<stretch>##
        libicu57 \
##</stretch>##
        libicu-dev \
    && docker-php-ext-install -j$(nproc) intl \
    && apt-get purge -y --auto-remove libicu-dev \
    && rm -rf /var/lib/apt/lists/*
##</intl>##

##<mcrypt>##
RUN apt-get update && apt-get install -y --no-install-recommends \
        libmcrypt4 libmcrypt-dev \
    && docker-php-ext-install -j$(nproc) mcrypt \
    && apt-get purge -y --auto-remove libmcrypt-dev \
    && rm -rf /var/lib/apt/lists/*
##</mcrypt>##

##<memcached>##
RUN apt-get update && apt-get install -y --no-install-recommends \
        libmemcached11 libmemcachedutil2 libmemcached-dev zlib1g zlib1g-dev \
    && pecl install -o -f memcached-2.2.0 \
    && rm -rf /tmp/pear \
    && docker-php-ext-enable memcached \
    && apt-get purge -y --auto-remove libmemcached-dev zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*
##</memcached>##

##<mongodb>##
RUN pecl install -o -f mongodb \
    && rm -rf /tmp/pear \
    && docker-php-ext-enable mongodb
##</mongodb>##

##<opcache>##
RUN docker-php-ext-install -j$(nproc) opcache
##</opcache>##


##<pcntl>##
RUN docker-php-ext-install -j$(nproc) pcntl
##</pcntl>##

##<pdo_mysql>##
RUN docker-php-ext-install -j$(nproc) pdo_mysql
##</pdo_mysql>##

##<pdo_pgsql>##
RUN apt-get update && apt-get install -y --no-install-recommends \
        libpq5 libpq-dev \
    && docker-php-ext-install -j$(nproc) pdo_pgsql \
    && apt-get purge -y --auto-remove libpq-dev \
    && rm -rf /var/lib/apt/lists/*
##</pdo_pgsql>##

##<protobuf>##
RUN pecl install -o -f protobuf \
    && rm -rf /tmp/pear \
    && docker-php-ext-enable protobuf
##</protobuf>##

##<redis>##
RUN pecl install -o -f redis-2.2.8 \
    && rm -rf /tmp/pear \
    && docker-php-ext-enable redis
##</redis>##

##<soap>##
RUN apt-get update && apt-get install -y --no-install-recommends \
        libxml2 libxml2-dev \
    && docker-php-ext-install -j$(nproc) soap \
    && apt-get purge -y --auto-remove libxml2-dev \
    && rm -rf /var/lib/apt/lists/*
##</soap>##

##<sockets>##
RUN docker-php-ext-install -j$(nproc) sockets
##</sockets>##

##<xsl>##
RUN apt-get update && apt-get install -y --no-install-recommends \
        libxslt1.1 libxslt1-dev \
    && docker-php-ext-install -j$(nproc) xsl \
    && apt-get purge -y --auto-remove libxslt1-dev \
    && rm -rf /var/lib/apt/lists/*
##</xsl>##

##<zip>##
RUN apt-get update && apt-get install -y --no-install-recommends \
        libzip4 libzip-dev \
    && docker-php-ext-install -j$(nproc) zip \
    && apt-get purge -y --auto-remove libzip-dev \
    && rm -rf /var/lib/apt/lists/*
##</zip>##

RUN echo "date.timezone=UTC" > /usr/local/etc/php/conf.d/timezone.ini
RUN echo "memory_limit=512M" > /usr/local/etc/php/conf.d/memory.ini

RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

##<xdebug>##
RUN pecl install -o -f xdebug-2.5.5 \
    && rm -rf /tmp/pear
##<xdebug-enable>##
RUN docker-php-ext-enable xdebug
##</xdebug-enable>##
##</xdebug>##

RUN mkdir -p /opt/workspace
WORKDIR /opt/workspace
