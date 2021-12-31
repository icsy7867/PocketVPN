#!/bin/bash

docker run -it --cap-add=NET_ADMIN --device /dev/net/tun --name vpn \
  -v "/etc/PocketVPN/openvpn/config/TorGuard.US-Inline.ovpn:/vpn/vpn.conf" \
  -v "/etc/PocketVPN/openvpn/auth:/auth" \
  -d dperson/openvpn-client

