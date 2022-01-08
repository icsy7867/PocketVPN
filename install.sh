#!/bin/bash
###Create PocketVPN Directories
mkdir -p /etc/PocketVPN/openvpn/config
mkdir -p /etc/PocketVPN/pihole/etc-pihole
mkdir -p /etc/PocketVPN/pihole/dnsmasq
mkfifo /etc/PocketVPN/pocket-pipe

cp -R ./openvpn_config_template/. /etc/PocketVPN/openvpn/config
cp ./listen-pipe.sh /etc/PocketVPN
cp iptables-* /etc/PocketVPN/openvpn/
cp PocketVPN-Listener.service /etc/systemd/system/

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

chmod +x /etc/PocketVPN/openvpn/*.sh
chmod +x /etc/PocketVPN/*.sh
apt-get update
apt-get install iptables-persistent


systemctl start PocketVPN-Listener.service
systemctl enable PocketVPN-Listener.service
