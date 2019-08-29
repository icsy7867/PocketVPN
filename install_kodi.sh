apt-get install kodi
cp /usr/share/applications/kodi.desktop /etc/xdg/autostart/z-kodi.desktop

wget -q https://github.com/CastagnaIT/plugin.video.netflix/archive/master.zip
sudo apt-get install -q python-crypto
sudo pip install -q -U setuptools
sudo pip install -q wheel
sudo pip install -q pycryptodomex==3.8.2


wget https://github.com/MediaBrowser/Emby.Releases/releases/download/4.2.1.0/emby-server-deb_4.2.1.0_armhf.deb
dpkg -i emby-server-deb_4.2.1.0_armhf.deb
