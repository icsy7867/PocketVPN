#!/bin/bash
while true
do
	cat /etc/PocketVPN/pocket-pipe | while read command output
	do
	    echo $command $output

	   case $command in
		openvpn_connect)
			iptables-save > /etc/PocketVPN/openvpn/iptables.save
			docker stop vpn
			docker rm vpn
			#docker run -it --cap-add=NET_ADMIN --device /dev/net/tun --name vpn \
			#	-v "/etc/PocketVPN/openvpn/config/${output}:/vpn/vpn.conf" \
			#	-v "/etc/PocketVPN/openvpn/auth:/auth" -d \
			#	--network host \
			#	dperson/openvpn-client -r 192.168.254.0/24
			#/usr/bin/sh /etc/PocketVPN/openvpn/iptables-init.sh
			echo "$command $output"
			/usr/sbin/openvpn --config /etc/PocketVPN/openvpn/config/${output} --log /etc/PocketVPN/openvpn/log --daemon &
			echo "======================="
			echo "Openvpn Process Started"
			echo "======================="
		;;
		openvpn_disconnect)
			docker stop vpn
			docker rm vpn
			#/usr/bin/sh /etc/PocketVPN/openvpn/iptables-restore.sh
			#killall openvpn
			echo "======================="
			echo "Openvpn Process Stopped"
			echo "======================="
		;;
	   esac
	done
done
