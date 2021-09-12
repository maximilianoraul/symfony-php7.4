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

# Use the default development configuration
RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"

RUN mkdir /.symfony && chmod 777 -R /.symfony

WORKDIR /app