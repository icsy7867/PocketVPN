#!/bin/sh

docker run -d -it -p 8080:80 --name pocketvpn-web -v "$PWD/website:/var/www/html" \
 -v "/sys/class/thermal/thermal_zone0/temp:/sys/class/thermal/thermal_zone0/temp:ro" \
 --privileged php:7.4-apache
