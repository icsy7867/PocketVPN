#!/bin/sh

docker run -d -it -p 8081:80 --name pocketvpn-web \
 -v "/sys/class/thermal/thermal_zone0/temp:/sys/class/thermal/thermal_zone0/temp:ro" \
 -v /var/run/docker.sock:/var/run/docker.sock \
 -v "/etc/PocketVPN/openvpn/config:/var/www/html/openvpn/config" \
 -v "/etc/PocketVPN/openvpn/auth:/var/www/html/openvpn/auth" \
 --privileged apachetest


#docker run -it --cap-add=NET_ADMIN --device /dev/net/tun --name vpn -v "/etc/PocketVPN/openvpn/config/TorGuard.US-Inline.ovpn:/vpn/vpn.conf" 
# -v "/etc/PocketVPN/openvpn/auth:/auth" -d dperson/openvpn-client
