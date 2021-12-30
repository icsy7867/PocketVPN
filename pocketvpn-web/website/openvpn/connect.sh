#!/bin/bash
echo "$1"
openvpn --config /var/www/html/openvpn/config/"$1"

#ufw reset
#ufw default deny incoming
#ufw default deny outgoing
#ufw allow out on tun0 from any to any
#ufw allow ssh
#ufw allow http
#ufw enable
