apt-get install kodi
cp /usr/share/applications/kodi.desktop /etc/xdg/autostart/z-kodi.desktop

wget -q https://github.com/CastagnaIT/plugin.video.netflix/archive/master.zip

wget https://github.com/MediaBrowser/Emby.Releases/releases/download/4.2.1.0/emby-server-deb_4.2.1.0_armhf.deb
dpkg -i emby-server-deb_4.2.1.0_armhf.deb
