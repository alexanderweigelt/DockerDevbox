FROM php:8.1-fpm

MAINTAINER Alexander Weigelt <webdesign@alexander-weigelt.de>

# Install dependencies
RUN apt-get update \
  && apt-get install -y \
    libfreetype6-dev \
    libicu-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng-dev \
    libxslt1-dev \
    sendmail-bin \
    sendmail \
    sudo \
    libzip-dev \
    libonig-dev \
# Configure the gd library
  && docker-php-ext-configure \
    gd --with-freetype --with-jpeg \
# Install required PHP extensions
  && docker-php-ext-install \
    dom \
    gd \
    intl \
    mbstring \
    pdo_mysql \
    xsl \
    zip \
    soap \
    bcmath \
    pcntl \
    sockets \
# Set ulimit for the web server user
  && ulimit -s 65536 \
# Setting the Timezone
  && rm /etc/localtime \
  && ln -s /usr/share/zoneinfo/Europe/Berlin /etc/localtime \
  && echo "Europe/Berlin" > /etc/timezone

ADD etc/mail.ini /usr/local/etc/php/conf.d/zz-mail.ini

ADD docker-entrypoint.sh /docker-entrypoint.sh

RUN ["chmod", "+x", "/docker-entrypoint.sh"]

ENTRYPOINT ["/docker-entrypoint.sh"]

ENV APP_ENV prod
ENV UPLOAD_MAX_FILESIZE 64M

ADD etc/php-fpm.ini /usr/local/etc/php/conf.d/zz-apo.ini

ADD etc/php-fpm.conf /usr/local/etc/

CMD ["php-fpm", "-F"]
