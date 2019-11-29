FROM php:7.4-cli

RUN apt-get update && apt-get install -y --no-install-recommends \
        curl \
        git \
# For composer
        unzip \
    && rm -rf /var/lib/apt/lists/*

##<apcu>##
RUN pecl install -o -f apcu \
    && rm -rf /tmp/pear \
    && docker-php-ext-enable --ini-name 0-apcu.ini apcu \
    && echo "apc.enable_cli=1" >> $PHP_INI_DIR/conf.d/0-apcu.ini
##</apcu>##

##<apcu_bc>##
RUN pecl install -o -f apcu_bc \
    && rm -rf /tmp/pear \
    && docker-php-ext-enable --ini-name 1-apc.ini apc
##</apcu_bc>##

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
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
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
##<buster>##
        libmagickwand-6.q16-6 \
##</buster>##
        libmagickwand-dev \
    && pecl install -o -f imagick \
    && rm -rf /tmp/pear \
    && docker-php-ext-enable imagick \
    && apt-get purge -y --auto-remove libmagickwand-dev \
    && rm -rf /var/lib/apt/lists/*
##</imagick>##

##<intl>##
RUN apt-get update && apt-get install -y --no-install-recommends \
##<buster>##
        libicu63 \
##</buster>##
        libicu-dev \
    && docker-php-ext-install -j$(nproc) intl \
    && apt-get purge -y --auto-remove libicu-dev \
    && rm -rf /var/lib/apt/lists/*
##</intl>##


##<memcached>##
RUN apt-get update && apt-get install -y --no-install-recommends \
        libmemcached11 libmemcachedutil2 libmemcached-dev zlib1g zlib1g-dev \
    && pecl install -o -f memcached \
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

##<opencensus>##
RUN curl -L https://github.com/census-instrumentation/opencensus-php/archive/master.tar.gz -o /tmp/opencensus.tar.gz \
    && mkdir -p /tmp/opencensus \
    && tar -xf /tmp/opencensus.tar.gz -C /tmp/opencensus --strip-components=1 \
    && rm /tmp/opencensus.tar.gz \
    && ( \
      cd /tmp/opencensus/ext \
      && phpize \
      && ./configure --enable-opencensus \
      && make -j "$(nproc)" \
      && make install \
    ) \
    && rm -r /tmp/opencensus \
    && docker-php-ext-enable opencensus
##</opencensus>##

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


##<redis>##
RUN pecl install -o -f redis \
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
RUN pecl install -o -f xdebug \
    && rm -rf /tmp/pear
##</xdebug>##

RUN mkdir -p /opt/workspace
WORKDIR /opt/workspace
