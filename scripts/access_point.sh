#!/bin/bash
sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get install hostapd dnsmasq dos2unix -y
sudo systemctl unmask hostapd
sudo systemctl enable hostapd
sudo printf "interface=wlan1\r\nssid=FenFen\r\nhw_mode=g\r\nchannel=11\r\nmacaddr_acl=0\r\nauth_algs=1\r\nwpa=2\r\nwpa_key_mgmt=WPA-PSK\r\nwpa_pairwise=TKIP\r\nrsn_pairwise=CCMP\r\nwpa_passphrase=godsword\n" >> /etc/hostapd/hostapd.conf
sudo printf "DAEMON_CONF=\"/etc/hostapd/hostapd.conf\"\n" >> /etc/default/hostapd
sudo printf "interface wlan1\r\n    nohook wpa_supplicant\n" >> /etc/dhcpcd.conf
sudo printf "allow-hotplug wlan0\r\niface wlan0 inet dhcp\r\n    wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf\r\niface default inet dhcp\r\n\r\nauto wlan1\r\niface wlan1 inet static\r\n    address 10.0.10.1\r\n    netmask 255.255.255.0\r\n    wireless-mode monitor\n" >> /etc/network/interfaces
sudo mv /etc/dnsmasq.conf /etc/dnsmasq.conf.orig
sudo printf "interface=wlan1\r\nserver=1.1.1.1\r\ndhcp-range=10.0.10.2,10.0.10.24,24h" >> /etc/dnsmasq.conf
sudo dos2unix /etc/hostapd/hostapd.conf /etc/default/hostapd /etc/dhcpcd.conf /etc/network/interfaces /etc/dnsmasq.conf
echo Done, please reboot


