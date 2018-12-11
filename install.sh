#!/bin/bash

echo 'Updating Apt...'
apt-get update

echo ''

echo 'Installing apache and dependencies'

cd website
./install.sh

echo ''

echo 'Installing hostapd, copying config files and setting up NAT'
cd ../hostap
./install.sh

echo ''

sleep 1

echo 'Complete!'
sleep 1
echo 'Please uncomment net.ipv4.ip_forward=1 in /etc/sysctl.conf and reboot!'

##Optional for Mikerr to prevent Chromium from updating and breaking
#apt-mark hold chromium-widevine
#apt-mark hold chromium
#apt-mark hold chromium-browser

## Auto start Kodi with xsession
#cp /usr/share/applications/kodi.desktop /etc/xdg/autostart/z-kodi.desktop
