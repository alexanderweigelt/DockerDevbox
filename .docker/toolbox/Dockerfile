ARG compose_project_name
ARG compose_image_tag

FROM $compose_project_name/devbox-php:$compose_image_tag

MAINTAINER Alexander Weigelt <webdesign@alexander-weigelt.de>

# Using composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
# Install Node.js
    && curl -sL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get update \
    && apt-get install -y \
        nano \
        vim \
        git \
        nodejs \
        openssh-server \
        mariadb-client \
## Creates a new user as www-data alias and adds it to the sudo group
## along with privileges to run sudo without password
    && adduser --disabled-password --uid 5577 --gecos "" --ingroup www-data app \
    && usermod -m -d /home/app www-data | true \
    && echo "app:app" | chpasswd \
    && usermod -a -G sudo app \
    && chmod g+rwx /home/app \
# Allow sudo without pwd and dont require tty (for entrypoint commands)
    && echo "Defaults:app !requiretty" >> /etc/sudoers \
    && sed -i 's/app:x:5577:33:/app:x:33:33:/g' /etc/passwd \
# Apply config and start the ssh server
    && sed -i 's/#   PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/ssh_config \
    && service ssh start \
# Install phpcs and phpcs-fixer
    && curl -L https://github.com/squizlabs/PHP_CodeSniffer/releases/latest/download/phpcs.phar -o /usr/local/bin/phpcs \
    && chmod +x /usr/local/bin/phpcs \
    && curl -sS -L https://github.com/FriendsOfPHP/PHP-CS-Fixer/releases/latest/download/php-cs-fixer.phar -o /usr/bin/php-cs-fixer \
    && chmod +x /usr/bin/php-cs-fixer \
# Install phpcbf
    && curl -L https://github.com/squizlabs/PHP_CodeSniffer/releases/latest/download/phpcbf.phar > /usr/local/bin/phpcbf \
    && chmod +x /usr/local/bin/phpcbf \
# Finally clean caches
    && rm -rf /var/cache/apk/* /var/tmp/* /tmp/*

ARG http_project_root
ENV HTTP_PROJECT_ROOT $http_project_root

# Add setup
ADD docker-entrypoint.sh /docker-entrypoint.sh
ADD scripts/ /home/app/

RUN chown -R 5577:www-data /home/app/bin \
    && chmod -R +x /home/app/bin

RUN ["chmod", "-R", "+x", "/docker-entrypoint.sh", "/home/app/bin"]

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["/usr/sbin/sshd","-D","php-fpm", "-F"]

WORKDIR $HTTP_PROJECT_ROOT
