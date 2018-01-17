FROM php:7.1-apache

MAINTAINER Alexander Weigelt <webdesign@alexander-weigelt.de>

# using composer version 1.5.2
RUN curl -sS https://getcomposer.org/installer | \
    php -- --install-dir=/usr/bin/ --filename=composer && \
    apt-get update && \
    apt-get install -y git && \
    apt-get install -y zip unzip

# Install php extensions
RUN apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng-dev \
        libxml2-dev \
        libxslt-dev \
        libicu-dev \
        libyaml-dev \
    && docker-php-ext-install -j$(nproc) \
        mysqli \
        mcrypt \
        pdo_mysql \
        opcache \
        json \
        calendar \
        bcmath \
        mbstring \
        soap \
        xsl \
        zip \
        intl \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

# Install PECL extensions
RUN pecl install redis-3.1.4 \
    && pecl install xdebug-2.5.0 \
    && pecl install yaml-2.0.2 \
    && docker-php-ext-enable redis xdebug yaml \
    && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_autostart=off" >> /usr/local/etc/php/conf.d/xdebug.ini

# Install Node.js
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash && \
    apt-get install -y nodejs build-essential

# Install Grunt CLI
RUN npm install -g grunt-cli

# Add setup
COPY setup/ /
RUN chmod +x /usr/local/bin/*

# enable mod_rewrite for Apache 2.2
RUN a2enmod rewrite \
    && service apache2 restart