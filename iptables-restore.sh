#!/bin.bash

# Accept all traffic first to avoid ssh lockdown  via iptables firewall rules #
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT

# Flush All Iptables Chains/Firewall rules #
iptables -F

# Delete all Iptables Chains #
iptables -X

# Flush and delete all nat and  mangle #
#iptables -t nat -F
#iptables -t nat -X
#iptables -t mangle -F
#iptables -t mangle -X

/usr/sbin/iptables-restore < /etc/PocketVPN/openvpn/iptables.save
