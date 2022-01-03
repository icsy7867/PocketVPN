#!/bin/bash -e

# Check if running in privileged mode
if [ ! -w "/sys" ] ; then
    echo "[Error] Not running in privileged mode."
    exit 1
fi

#Clean any previous files
rm -rf /run/dhcp/dhcpd.pid

# Default values
true ${INTERFACE:=wlan0}
true ${SUBNET:=192.168.254.0}
true ${AP_ADDR:=192.168.254.1}
true ${SSID:=PocketVPN}
true ${CHANNEL:=7}
true ${WPA_PASSPHRASE:=1234567890}
true ${HW_MODE:=g}
true ${DRIVER:=nl80211}
true ${HT_CAPAB:=[MAX-AMSDU-3839][HT40+][SHORT-GI-20][SHORT-GI-40][DSSS_CCK-40]}
true ${MODE:=host}
true ${COUNTRY:=US}

iw reg set ${COUNTRY}

# Attach interface to container in guest mode
if [ "$MODE" == "guest"  ]; then
    echo "Attaching interface to container"

    CONTAINER_ID=$(cat /proc/self/cgroup | grep -o  -e "/docker/.*" | head -n 1| sed "s/\/docker\/\(.*\)/\\1/")
    CONTAINER_PID=$(docker inspect -f '{{.State.Pid}}' ${CONTAINER_ID})
    CONTAINER_IMAGE=$(docker inspect -f '{{.Config.Image}}' ${CONTAINER_ID})

    docker run -t --privileged --net=host --pid=host --rm --entrypoint /bin/sh ${CONTAINER_IMAGE} -c "
        PHY=\$(echo phy\$(iw dev ${INTERFACE} info | grep wiphy | tr ' ' '\n' | tail -n 1))
        iw phy \$PHY set netns ${CONTAINER_PID}
    "

    ip link set ${INTERFACE} name wlan0

    INTERFACE=wlan0
fi

if [ ! -f "/etc/hostapd.conf" ] ; then
    cat > "/etc/hostapd.conf" <<EOF
interface=wlan0
driver=nl80211
ssid=pocket

# 2.4 GHz settings
#hw_mode=g
#channel=1
#country_code=US

# 5.0 GHz settings
hw_mode=a
channel=36
country_code=US

# N
ieee80211n=1
require_ht=1
ht_capab=[HT40+][SHORT-GI-20][SHORT-GI-40][MAX-AMSDU-3839][DSSS_CCK-40]

# AC
ieee80211ac=1
require_vht=1
ieee80211d=0
ieee80211h=0
vht_capab=[MAX-MPDU-3895][SHORT-GI-80][SU-BEAMFORMEE]
vht_oper_chwidth=1
vht_oper_centr_freq_seg0_idx=42

wme_enabled=1
wmm_enabled=1
max_num_sta=2

wpa=2
auth_algs=1

rsn_pairwise=CCMP
wpa_key_mgmt=WPA-PSK
wpa_passphrase=1234567890

logger_stdout=-1
logger_stdout_level=4
ctrl_interface=/var/run/hostapd
ctrl_interface_group=0
EOF

fi

# unblock wlan
rfkill unblock wlan
sleep 5
echo "Setting interface ${INTERFACE}"

# Setup interface and restart DHCP service 
ip link set ${INTERFACE} up
ip addr flush dev ${INTERFACE}
ip addr add ${AP_ADDR}/24 dev ${INTERFACE}

# NAT settings
echo "NAT settings ip_dynaddr, ip_forward"

for i in ip_dynaddr ip_forward ; do 
  if [ $(cat /proc/sys/net/ipv4/$i) ]; then
    echo $i already 1 
  else
    echo "1" > /proc/sys/net/ipv4/$i
  fi
done

cat /proc/sys/net/ipv4/ip_dynaddr 
cat /proc/sys/net/ipv4/ip_forward

if [ "${OUTGOINGS}" ] ; then
   ints="$(sed 's/,\+/ /g' <<<"${OUTGOINGS}")"
   for int in ${ints}
   do
      echo "Setting iptables for outgoing traffics on ${int}..."
      iptables -t nat -D POSTROUTING -s ${SUBNET}/24 -o ${int} -j MASQUERADE > /dev/null 2>&1 || true
      iptables -t nat -A POSTROUTING -s ${SUBNET}/24 -o ${int} -j MASQUERADE

      iptables -D FORWARD -i ${int} -o ${INTERFACE} -m state --state RELATED,ESTABLISHED -j ACCEPT > /dev/null 2>&1 || true
      iptables -A FORWARD -i ${int} -o ${INTERFACE} -m state --state RELATED,ESTABLISHED -j ACCEPT

      iptables -D FORWARD -i ${INTERFACE} -o ${int} -j ACCEPT > /dev/null 2>&1 || true
      iptables -A FORWARD -i ${INTERFACE} -o ${int} -j ACCEPT
   done
else
   echo "Setting iptables for outgoing traffics on all interfaces..."
   iptables -t nat -D POSTROUTING -s ${SUBNET}/24 -j MASQUERADE > /dev/null 2>&1 || true
   iptables -t nat -A POSTROUTING -s ${SUBNET}/24 -j MASQUERADE

   iptables -D FORWARD -o ${INTERFACE} -m state --state RELATED,ESTABLISHED -j ACCEPT > /dev/null 2>&1 || true
   iptables -A FORWARD -o ${INTERFACE} -m state --state RELATED,ESTABLISHED -j ACCEPT

   iptables -D FORWARD -i ${INTERFACE} -j ACCEPT > /dev/null 2>&1 || true
   iptables -A FORWARD -i ${INTERFACE} -j ACCEPT
fi
echo "Configuring DHCP server .."

cat > "/etc/dhcp/dhcpd.conf" <<EOF
option domain-name-servers 192.168.254.1;
option subnet-mask 255.255.255.0;
option routers ${AP_ADDR};
subnet ${SUBNET} netmask 255.255.255.0 {
  range ${SUBNET::-1}100 ${SUBNET::-1}200;
}
EOF

echo "Starting DHCP server .."
dhcpd ${INTERFACE}

echo "Starting HostAP daemon ..."
/usr/sbin/hostapd /etc/hostapd.conf &

echo "Starting loop to verify state of hostapd"
sleep 2
while true
do

        if [ "$(hostapd_cli status | grep state | grep -c 'ENABLED')" -ne 1 ]; then
                exit
        else
                sleep 1
        fi
done
