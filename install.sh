#!/bin/bash
echo 'Installing apache and dependencies'
./website/install.sh

echo ''
echo ''

echo 'Installing hostapd, copying config files and setting up NAT'
./hostap/install.sh

echo ''
echo ''

sleep 100

echo 'Complete!'
sleep 100
echo 'Please run echo 1 > /proc/sys/net/ipv4/ip_forward as root if you have not done so already'
