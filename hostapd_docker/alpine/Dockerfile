from alpine

# Install packages
RUN apk update && apk add hostapd iw dhcp vim iptables

# Configure Hostapd (default will be open)
ADD confs/hostapd.conf /etc/hostapd/hostapd.conf
# Configure DHCPD
ADD confs/dnsmasq.conf /etc/dnsmasq.conf
#RUN touch /var/lib/dhcp/dhcpd.leases

# Configure networking
ADD confs/interfaces /etc/network/interfaces
ADD confs/iptables.sh /iptables.sh
ADD confs/iptables_off.sh /iptables_off.sh

# Copy and execute init file
ADD confs/start.sh /start.sh
CMD ["/bin/sh", "/start.sh"]
