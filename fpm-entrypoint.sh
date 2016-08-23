#!/bin/bash
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
erb -T - /php-fpm.conf.erb > /usr/local/etc/php-fpm.conf
erb -T - /phabricator.json.erb > /var/www/phabricator/phabricator/conf/local/local.json
exec ${@}
