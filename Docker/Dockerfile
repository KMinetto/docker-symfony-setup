FROM php:8.1-fpm

RUN apt-get update
RUN apt-get install -y --no-install-recommends locales apt-utils git libicu-dev g++ libpng-dev libxml2-dev libzip-dev libonig-dev libxslt-dev unzip

RUN echo "en_US.URF-8 UTF-8" > /etc/locale.gen \
   && echo "fr_FR.UTF-8 UTF-8" >> /etc/locale.gen \
   && locale-gen

RUN curl -sS https://getcomposer.org/installer | php -- && mv composer.phar /usr/local/bin/composer

RUN curl -sL https://deb.nodesource.com/setup_18.x | bash && apt-get install nodejs

RUN docker-php-ext-configure intl && docker-php-ext-install pdo pdo_mysql opcache intl zip calendar dom mbstring gd xsl

RUN pecl install apcu && docker-php-ext-enable apcu

WORKDIR /var/www/