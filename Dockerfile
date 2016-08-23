FROM php:5.6-fpm
MAINTAINER maksim@nightbook.info

RUN apt-get update
RUN apt-get install --no-install-recommends --no-install-suggests -y ruby git
RUN apt-get install --no-install-recommends --no-install-suggests -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
    && docker-php-ext-install -j$(nproc) iconv mcrypt pcntl mysql mysqli pdo pdo_mysql opcache\
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/www/phabricator
WORKDIR /var/www/phabricator
RUN git clone https://github.com/phacility/libphutil.git
RUN git clone https://github.com/phacility/arcanist.git
RUN git clone https://github.com/phacility/phabricator.git

COPY php-fpm.conf.erb /php-fpm.conf.erb
COPY phabricator.json.erb /phabricator.json.erb

COPY fpm-entrypoint.sh /entrypoint
RUN chmod +x /entrypoint

EXPOSE 9000

ENTRYPOINT [ "/entrypoint" ]

CMD ["php-fpm", "-F", "-R", "-c /usr/local/etc/php-fpm.conf"]
