Tested on Mikerr's Tinkerboard 2.0.4 and 2.0.7
**Should work on Raspberry Pi, but untested 

![alt text](https://i.imgur.com/gIFD5Ra.png "Status Page")

![alt text](https://i.imgur.com/2SgqK3r.png "Settings Page")

![alt text](https://i.imgur.com/XLpTIWD.png "Information Page")

# Installation
```
git clone https://github.com/ICANSEEYOU7687/PocketVPN
cd PocketVpn
sudo chmod +x install.sh
sudo ./install.sh
```

You should not see any errors.
Also make sure to set ipv4 forwarding!

```
Please uncomment net.ipv4.ip_forward=1 in /etc/sysctl.conf and reboot!
```

```
Once installed, connect to "PocketVPN" SSID and access the web interface:
http://192.168.4.1

Default Username: admin
Default Password: 1234567890
(Please change in settings in the web gui)
```
```
Also set your VPN provider Username/Password in the settings.
```
```
You should be able to see "PocketVPN" SSID on your devices.  Default wifi password is 1234567890
```
# Additional Notes
Please streamline your openvpn configs by including your TLS and CA certificates within you .ovpn file.

Additionally please also include the auth file in your ovpn configs.

Your ovpn files should have this structure at the end of them
```
auth-user-pass /var/www/html/openvpn/auth
key-direction 1 #this may or may not be needed depending on the OpenVPN server.
<tls-auth>
#
# 2048 bit OpenVPN static key
#
-----BEGIN OpenVPN Static key V1-----
Key here
-----END OpenVPN Static key V1-----
</tls-auth>

<ca>
-----BEGIN CERTIFICATE-----
CA Cert(s) here
-----END CERTIFICATE-----
</ca>
```
