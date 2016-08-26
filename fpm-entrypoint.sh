#!/bin/bash
source /phabricator_configs_init.sh
erb -T - /php-fpm.conf.erb > /usr/local/etc/php-fpm.conf
erb -T - /msmtp.conf.erb > /etc/msmtp.conf
mkdir -p "${REPOSITORY_LOCAL_PATH}"
exec ${@}
