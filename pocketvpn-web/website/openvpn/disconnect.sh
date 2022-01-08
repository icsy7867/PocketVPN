#!/bin/bash
#sudo killall openvpn
echo "openvpn_disconnect true" > /pocket-pipe &
#ufw --force reset
#ufw default deny incoming
#ufw default allow outgoing
#ufw allow ssh
#ufw allow http
#ufw --force enable

