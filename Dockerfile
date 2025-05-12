ARG ARCH=
FROM ${ARCH}php:7.4-cli-alpine

RUN apk add --no-cache openssh git gnu-libiconv mysql-dev mariadb-client \
	autoconf linux-headers cmake g++ gcc libzmq zeromq-dev zeromq coreutils build-base file ssmtp libxml2-dev libuv libevent-dev libuv-dev libzip-dev \
	&& rm -rf /var/cache/apk/* \
  && docker-php-ext-install sockets \
	&& git clone https://github.com/zeromq/php-zmq.git \
	&& cd php-zmq \
	&& phpize \
	&& ./configure \
	&& make \
	&& make install \
	&& pecl install event-2.4.2 \
	&& docker-php-ext-install mysqli pdo_mysql pcntl zip soap \
 	&& docker-php-ext-enable zmq event \
	&& rm -rf /tmp/pear \
	&& curl -fsSL https://getcomposer.org/installer | php \
	&& mv composer.phar /usr/local/bin/composer \
#	&& apk del autoconf gcc libzmq zeromq-dev coreutils build-base libuv-dev mysql-dev \
#	mariadb-dev zlib-dev libc-dev musl-dev pkgconf m4 perl g++ make libressl-dev zeromq-dev \
	&& addgroup -g 1000 -S scroll \
	&& adduser -u 1000 -D -S -G scroll scroll

#RUN mkdir /libm
#ADD mysql-connector-c /libm
#WORKDIR /libm
#RUN cd /libm && cmake -G "Unix Makefiles" -DCMAKE_C_COMPILER=/usr/bin/gcc -DCMAKE_CXX_COMPILER=/usr/bin/g++ -DCMAKE_MAKE_PROGRAM=/usr/bin/make
#RUN make

