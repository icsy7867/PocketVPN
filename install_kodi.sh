apt-get install kodi
cp /usr/share/applications/kodi.desktop /etc/xdg/autostart/z-kodi.desktop

wget https://raw.githubusercontent.com/zjoasan/netflix-install-script/master/netflix_prep_install.sh
chmod +x netflix_prep_install.sh
./netflix_prep_install.sh

wget https://github.com/MediaBrowser/Emby.Releases/releases/download/4.2.1.0/emby-server-deb_4.2.1.0_armhf.deb
dpkg -i emby-server-deb_4.2.1.0_armhf.deb