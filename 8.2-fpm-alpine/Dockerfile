FROM php:8.2-fpm-alpine

ADD ./ext/*.tgz /usr/src/php/ext

RUN set -eux ; \
    sed -i s/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g /etc/apk/repositories \
    && apk update \
    && apk add --no-cache supervisor libjpeg-turbo-dev libpng-dev freetype-dev libffi-dev libzip-dev librdkafka-dev \
    && mv /usr/src/php/ext/rdkafka-* /usr/src/php/ext/rdkafka  \
    && mv /usr/src/php/ext/redis-* /usr/src/php/ext/redis  \
    && mv /usr/src/php/ext/swoole-* /usr/src/php/ext/swoole \
    && docker-php-ext-configure gd --with-jpeg --with-freetype \
    && docker-php-ext-install -j$(nproc) opcache gd pdo_mysql zip bcmath sockets ffi pcntl redis rdkafka swoole \
    && docker-php-source delete

ENTRYPOINT ["supervisord", "-n", "-c", "/etc/supervisord.conf"]
