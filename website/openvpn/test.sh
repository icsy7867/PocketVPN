#!/bin/bash
sed -e '/^<VirtualHost/{:a' -e 'n;/^<\/VirtualHost/!ba' \
    -e 'r inserted.txt' -e '}' /etc/apache2/sites-enabled/000-default.conf
