FROM php:8.1-fpm

MAINTAINER Alexander Weigelt <webdesign@alexander-weigelt.de>

# Install dependencies
RUN apt-get update \
  && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libwebp-dev \
    libxslt-dev \
    sendmail-bin \
    sendmail \
    sudo \
    libzip-dev \
    libonig-dev \
# Configure the gd library
  && docker-php-ext-configure \
    gd --with-freetype --with-jpeg --with-webp \
# Install required PHP extensions
  && docker-php-ext-install \
    dom \
    intl \
    mbstring \
    pdo_mysql \
    xsl \
    zip \
    soap \
    bcmath \
    pcntl \
# Install Xdebug (but don't enable)
  && pecl install -o -f xdebug \
# Set ulimit for the web server user
  && ulimit -s 65536 \
# Setting the Timezone
  && rm /etc/localtime \
  && ln -s /usr/share/zoneinfo/Europe/Berlin /etc/localtime \
  && echo "Europe/Berlin" > /etc/timezone

# Add setup
ADD etc/mail.ini /usr/local/etc/php/conf.d/zz-mail.ini
ADD etc/php-xdebug.ini /usr/local/etc/php/conf.d/zz-xdebug-settings.ini

ADD docker-entrypoint.sh /docker-entrypoint.sh

RUN ["chmod", "+x", "/docker-entrypoint.sh"]

ENTRYPOINT ["/docker-entrypoint.sh"]

ENV APP_ENV prod
ENV UPLOAD_MAX_FILESIZE 64M

ADD etc/php-fpm.ini /usr/local/etc/php/conf.d/zz-app.ini

ADD etc/php-fpm.conf /usr/local/etc/

CMD ["php-fpm", "-F"]
