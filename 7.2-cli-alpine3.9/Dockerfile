FROM php:7.2-cli-alpine3.9

RUN apk add --no-cache openssh git mysql-dev mariadb-client \
	autoconf gcc libzmq zeromq-dev zeromq coreutils build-base file ssmtp libuv libuv-dev \
	&& rm -rf /var/cache/apk/* \
	&& pecl install uv-beta \
	&& pecl install zmq-beta \
	&& docker-php-ext-install mysqli pdo_mysql pcntl \
 	&& docker-php-ext-enable zmq uv \
	&& rm -rf /tmp/pear \
	&& curl -fsSL https://getcomposer.org/installer | php \
	&& mv composer.phar /usr/local/bin/composer \
	&& apk del autoconf gcc libzmq zeromq-dev coreutils build-base libuv-dev mysql-dev \
	mariadb-dev zlib-dev libc-dev musl-dev pkgconf m4 perl g++ make libressl-dev zeromq-dev

RUN addgroup -g 1000 -S scroll \
	&& adduser -u 1000 -D -S -G scroll scroll
