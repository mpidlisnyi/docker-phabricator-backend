#!/bin/bash
source /phabricator_configs_init.sh
erb -T - /php-fpm.conf.erb > /usr/local/etc/php-fpm.conf
bin/storage upgrade --force 2>&1 >/dev/null
exec ${@}
