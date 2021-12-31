#!/bin/bash
###Create PocketVPN Directories
mkdir -p /etc/PocketVPN/openvpn/config
cp -R ./openvpn_config_template/. /etc/PocketVPN/openvpn/config

if [ ! -f /etc/PocketVPN/openvpn/auth ]
then
    touch /etc/PocketVPN/openvpn/auth
else
    echo "Auth File exists"
fi

chown -R root:root /etc/PocketVPN/openvpn
chown -R 33:root /etc/PocketVPN/openvpn/config
chown 33:root /etc/PocketVPN/openvpn/auth
chown 33:root /etc/PocketVPN/openvpn/config
