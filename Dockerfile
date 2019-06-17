FROM php:7.2-cli-alpine3.9

RUN apk add --no-cache openssh git mariadb-client \
	libzmq zeromq-dev zeromq coreutils build-base autoconf file ssmtp libuv libuv-dev \
	&& rm -rf /var/cache/apk/* \
	&& pecl install uv-beta \
	&& pecl install zmq-beta \
	&& docker-php-ext-install mysqli pdo_mysql pcntl \
 	&& docker-php-ext-enable zmq uv \
	&& rm -rf /tmp/pear \
	&& curl -fsSL https://getcomposer.org/installer | php \
	&& mv composer.phar /usr/local/bin/composer \
	&& apk del coreutils build-base autoconf zeromq-dev \
	&& addgroup -g 1000 -S scroll \
	&& adduser -u 1000 -D -S -G scroll scroll
