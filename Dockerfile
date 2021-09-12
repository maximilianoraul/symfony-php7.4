FROM php:7.4-fpm

RUN apt-get update && apt-get install -y \
    git \
    libicu-dev \
    && rm -rf /var/lib/apt/lists/*

#Install Symfony CLI
RUN curl -O https://get.symfony.com/cli/installer \
    && bash installer \
    && mv /root/.symfony/bin/symfony /usr/local/bin/symfony

#PHP Extensions
RUN docker-php-ext-install intl

#Composer
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer && chmod +x /usr/local/bin/composer

# Use the default development configuration
RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

RUN mkdir /.symfony && chmod 777 -R /.symfony
RUN mkdir /.composer && chmod 777 -R /.composer

WORKDIR /app