FROM php:7.2-fpm

RUN apt-get update && apt-get install -y \
    libpq-dev \
    libcurl4-gnutls-dev \
    libicu-dev \
    libmcrypt-dev \
    libxml2-dev \
    libzip-dev

RUN docker-php-ext-install \
    pdo \
    pdo_pgsql \
    pgsql \
    mbstring \
    curl \
    intl \
    json \
    iconv \
    xml \
    zip \
    bcmath \
    soap \
    pcntl \
    sysvsem

RUN pecl install redis-3.1.6 \
    && docker-php-ext-enable redis

RUN usermod -u 1000 www-data

WORKDIR /var/www/caloriestabilizer/

ADD docker/php-fpm.conf /etc/php/7.2/fpm/pool.d/
ADD docker/php.ini /usr/local/etc/php
ADD docker/nginx.conf /etc/nginx/conf.d/
COPY . /var/www/caloriestabilizer

ENV COMPOSER_ALLOW_SUPERUSER 1

RUN curl -O https://getcomposer.org/composer.phar && \
    php composer.phar install --prefer-dist --no-dev --no-autoloader --no-scripts --no-interaction --no-suggest && \
    php composer.phar clear-cache && \
    php composer.phar dump-autoload --optimize --classmap-authoritative --no-dev


VOLUME /var/www/caloriestabilizer
VOLUME /etc/nginx/conf.d
