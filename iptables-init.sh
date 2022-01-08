
#sudo iptables -F
iptables -A INPUT -i eth0 -m state --state NEW -p udp --dport 1194 -j ACCEPT
iptables -A INPUT -i tun+ -j ACCEPT
iptables -A FORWARD -i tun+ -j ACCEPT
iptables -A FORWARD -i tun+ -o eth0 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i tun+ -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i eth0 -o tun+ -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i wlan0 -o tun+ -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -o tun+ -j ACCEPT
iptables -I FORWARD -i tun0 -j ACCEPT
iptables -I FORWARD -o tun0 -j ACCEPT

iptables -t nat -A POSTROUTING -s 10.35.0.0/24 -o eth0 -j MASQUERADE
