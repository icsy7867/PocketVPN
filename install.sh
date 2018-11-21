#!/bin/bash
echo 'Installing apache and dependencies'

cd website
./install.sh

echo ''
echo ''

echo 'Installing hostapd, copying config files and setting up NAT'
cd ../hostap
./install.sh

echo ''
echo ''

sleep 1

echo 'Complete!'
sleep 1
echo 'Please uncomment net.ipv4.ip_forward=1 in /etc/sysctl.conf and reboot!'
