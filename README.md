# Php docker image

Image used for running php tests on our ci server.

This image is not designed for production use, rather is helpful for running 
some commands that might need extensions enabled.

Images are based on the `php:cli` upstream.

## Tags available

* `7`, `latest`
* `7-xdebug`
* `7.4`
* `7.4-xdebug`
* `7.3`
* `7.3-xdebug`
* `7.2`
* `7.2-xdebug`
* `5`
* `5-xdebug`
* `5.5`
* `5.5-xdebug`

## Extensions

All images have a number of extensions enabled.

- apcu
- apcu_bc
- bcmath
- gd
- grpc
- imagick
- intl
- mbstring
- mcrypt - Only on PHP 5 images.
- memcached
- mongodb
- opcache
- opencensus
- pcntl
- pdo_mysql
- pdo_pgsql
- protobuf
- redis
- soap
- sockets
- xsl
- xdebug - All images have `xdebug` installed, but the `xdebug` tag has it enabled.
- zip

The latest version is used where ever possible, 
some are pinned to older versions for PHP 5 images.

## Build command

    docker build -t ekreative/php .

## Build an app

    docker run -ti --rm --volume=$(pwd):/opt/workspace ekreative/php ./bin/phpunit

## Info

I have used https://github.com/mlocati/docker-php-extension-installer has been a
great to get extensions installed. There are a couple that are not using it
because they are not currently supported.

## Add new versions

To add dockerfiles for new PHP versions edit the `update.sh` file and run it, all the other files are generated automatically.
