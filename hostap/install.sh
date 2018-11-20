#!/bin/bash
apt-get install dnsmasq wireless-tools


echo "auto wlan0" >> /etc/network/interfaces
echo "allow-hotplug wlan0" >> /etc/network/interfaces
echo "iface wlan0 inet manual" >> /etc/network/interfaces

cp rc.local /etc/rc.local
cp hostapd.conf /etc/hostapd/hostapd.conf
cp dnsmasq.conf /etc/dnsmasq.conf
cp default_hostapd /etc/default/hostapd
cp resolv.dnsmasq.conf /etc/resolv.dnsmasq.conf
cp Channel_Select.sh /var/www/html/scripts/Channel_Select.sh

echo 1 > /proc/sys/net/ipv4/ip_forward

#brctl addbr br0
#brctl addif br0 eth0

#echo "" >> /etc/network/interfaces
#echo "auto br0" >> /etc/network/interfaces
#echo "iface br0 inet manual" >> /etc/network/interfaces
#echo "bridge_ports eth0 wlan0" >> /etc/network/interfaces

#iptables -t nat -A  POSTROUTING -o eth0 -j MASQUERADE
#sh -c "iptables-save > /etc/iptables.ipv4.nat"
cp iptables.record /etc/iptables.ipv4.nat

cp starthostapd.sh /var/www/html/scripts/starthostapd.sh
