FROM mpidlisnyi/phabricator-base:latest
MAINTAINER maksim@nightbook.info

COPY php-fpm.conf.erb /php-fpm.conf.erb

COPY fpm-entrypoint.sh /entrypoint
RUN chmod +x /entrypoint
WORKDIR /srv/phabricator

EXPOSE 9000

ENTRYPOINT [ "/entrypoint" ]

CMD ["php-fpm", "-F", "-R", "-c /usr/local/etc/php-fpm.conf"]
