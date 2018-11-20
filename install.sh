echo 'Installing apache and dependencies'
.website/install.sh

echo 'Installing hostapd, copying config files and setting up NAT'
.hostap/install.sh

sleep 100

echo 'Complete!'
echo 'Please run'
