#!/bin/bash
while true
do
	cat /etc/PocketVPN/pocket-pipe | while read command output
	do
	    echo $command $output

	   case $command in
		openvpn_connect)
			docker stop vpn
			docker rm vpn
			docker run -it --cap-add=NET_ADMIN --device /dev/net/tun --name vpn \
				-v "/etc/PocketVPN/openvpn/config/${output}:/vpn/vpn.conf" \
				-v "/etc/PocketVPN/openvpn/auth:/auth" -d \
				--network host \
				dperson/openvpn-client -r 192.168.254.0/24
		;;
		openvpn_disconnect)
			docker stop vpn
			docker rm vpn
		;;
	   esac
	done
done
