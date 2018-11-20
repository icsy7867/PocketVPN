#!/bin/bash
apt-get install nano openvpn apache2 php libapache2-mod-php sudo -y

#me="$(whoami)"
#usermod -aG sudo $me

echo "Setting up .htaccess files..."
mkdir /httpaccess
touch  /httpaccess/.htpasswd
chown www-data:root /httpaccess/.htpasswd
chmod 770 /httpaccess/.htpasswd

#echo "If you want to include htaccess, first go to the website -> Settings and change the webpassword, and then add this to your apache virtual directory:
#  <Directory "/var/www/html">
#      AuthType Basic
#      AuthName "Restricted Content"
#      AuthUserFile /httpaccess/.htpasswd
#      Require valid-user
#  </Directory>"

echo "Setting permissions..."
chown -R www-data:www-data *
chown -R root:root openvpn/*
chown -R www-data:root openvpn/config/*
chown www-data:root openvpn/auth
chown www-data:root openvpn/config
chown www-data:root openvpn/openvpn_connect.log

echo "Setting www-data passwordless sudo privileges to vpn scripts"
echo "www-data ALL = (root) NOPASSWD: /var/www/html/openvpn/connect.sh" >> /etc/sudoers
echo "www-data ALL = (root) NOPASSWD: /var/www/html/openvpn/disconnect.sh" >> /etc/sudoers
echo "www-data ALL = (root) NOPASSWD: /var/www/html/scripts/webpass.sh" >> /etc/sudoers
echo "www-data ALL = (root) NOPASSWD: /usr/bin/htpasswd" >> /etc/sudoers
echo "www-data ALL = (root) NOPASSWD: /var/www/html/scripts/power.sh" >> /etc/sudoers

echo "copying website files over..."
rm /var/www/html/index.html
cp -rp * /var/www/html

# Set default password to 1234567890
echo "Setting web interface password to admin/1234567890"
/usr/bin/htpasswd -b /httpaccess/.htpasswd admin 1234567890

# cp apache conf file to apache sites-enabled directory
echo "Moving apache2 conf file over... and restarting apache"
cp installation_files/000-default.conf /etc/apache2/sites-available/000-default.conf

#File clean up
echo "Cleaning up files..."
rm /var/www/html/install.sh
rm -rf /var/www/html/installation_files


echo "restarting apache2"
service apache2 restart
