#!/bin/bash

if [ "$1" -eq "1" ]; then
	service hostapd stop
	sleep 1
	killall wpa_supplicant
	sleep 1
	service hostapd restart
fi

if [ "$1" -eq "0" ]; then
	service hostapd stop
fi
