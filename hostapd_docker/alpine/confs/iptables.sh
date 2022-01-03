#! /bin/sh
iptables-nft -t nat -C POSTROUTING -o eth0 -j MASQUERADE || iptables-nft -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables-nft -C FORWARD -i eth0 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT || iptables-nft -A FORWARD -i eth0 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables-nft -C FORWARD -i wlan0 -o eth0 -j ACCEPT || iptables-nft -A FORWARD -i wlan0 -o eth0 -j ACCEPT
