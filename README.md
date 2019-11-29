# Php docker image

Image used for running php tests on our ci server.

This image is not designed for production use, rather is helpful for running 
some commands that might need extensions enabled.

Images are based on the `php:cli` upstream.

## Tags available

* `7`, `latest`
* `7-xdebug`
* `7.4-rc`
* `7.4-rc-xdebug`
* `7.3`
* `7.3-xdebug`
* `7.2`
* `7.2-xdebug`
* `5`
* `5-xdebug`
* `5.5`
* `5.5-xdebug`

## Extensions

All images have a number of extensions enabled

- intl
- mbstring
- pdo_mysql
- pcntl
- xsl
- xip
- soap
- bcmath
- redis
- memcached
- mongodb
- imagick
- apcu
- apcu_bc
- xdebug - All images have `xdebug` installed, but the `xdebug` tag has it enabled.
- mcrypt - Only on PHP 5 images.

The latest version is used where ever possible, 
some are pinned to older versions for PHP 5 images.

## Build command

    docker build -t ekreative/php .

## Build an app

    docker run -ti --rm --volume=$(pwd):/opt/workspace ekreative/php ./bin/phpunit
