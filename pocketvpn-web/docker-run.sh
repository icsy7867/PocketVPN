#!/bin/sh

docker run -d -it -p 8081:80 --name pocketvpn-web \
 -v "/sys/class/thermal/thermal_zone0/temp:/sys/class/thermal/thermal_zone0/temp:ro" \
 -v /var/run/docker.sock:/var/run/docker.sock \
 -v "/etc/PocketVPN/openvpn/config:/var/www/html/openvpn/config" \
 --privileged apachetest

