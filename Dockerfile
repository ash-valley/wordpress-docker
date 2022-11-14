FROM php:8.0-apache

RUN apt-get update && apt-get upgrade -yy \
    && apt-get install -yy --no-install-recommends \
        apt-utils \
        libjpeg-dev \
        libpng-dev \
        libwebp-dev \
        libzip-dev \
        zlib1g-dev \
        libfreetype6-dev \
        supervisor zip \
        unzip \
        software-properties-common \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN docker-php-ext-install zip \
    && docker-php-ext-install mysqli pdo pdo_mysql \
    && docker-php-ext-install exif \
    && docker-php-ext-configure gd --with-freetype --with-jpeg --with-webp \
    && docker-php-ext-install -j "$(nproc)" gd \
    && a2enmod rewrite

RUN sed -i 's/80/${PORT}/g' /etc/apache2/sites-available/000-default.conf /etc/apache2/ports.conf

WORKDIR /var/www/html
COPY ./wordpress /var/www/html/
