#!/bin/bash
###Create PocketVPN Directories
mkdir -p /etc/PocketVPN/openvpn/config
mv ./pocketvpn-web/website/openvpn/config /etc/PocketVPN/openvpn/
touch /etc/PocketVPN/openvpn/auth

chown -R root:root /etc/PocketVPN/openvpn
chown -R 33:root /etc/PocketVPN/openvpn/config/*
chown 33:root /etc/PocketVPN/openvpn/auth
chown 33:root /etc/PocketVPN/openvpn/config
