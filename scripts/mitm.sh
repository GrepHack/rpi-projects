#!/bin/bash
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install python3
sudo apt-get install python3-pip
# sudo apt-get install openssl ?????
sudo pip install setuptools
sudo pip install virtualenv virtualenvwrapper
mkvirtualenv -p /usr/bin/python3 mitmproxy
mkdir virtualenv
export PROJECT_HOME=~/virtualenv/
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python
mkproject -p /usr/bin/python3 mitmproxy
# sudo apt-get install build-essential libssl-dev libffi-dev python3-dev python-dev
# sudo apt-get install libffi-dev libjpeg-dev
apt-get install libssl-dev
sudo apt-get install build-essential tk-dev libncurses5-dev libncursesw5-dev libreadline6-dev libdb5.3-dev libgdbm-dev libsqlite3-dev libssl-dev libbz2-dev libexpat1-dev liblzma-dev zlib1g-dev

# only support PYTHON3
sudo pip3 install mitmproxy
# start a transparent proxy
sudo sysctl -w net.ipv4.ip_forward=1
# clean old firewall
sudo iptables -F
sudo iptables -X
sudo iptables -t nat -F
sudo iptables -t nat -X
sudo iptables -t mangle -F
sudo iptables -t mangle -X

# nat on the local lan
sudo iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE
sudo iptables -A FORWARD -i wlan0 -o wlan1 -m state --state RELATED,ESTABLISHED -j ACCEPT

# forward all requests to the proxy
sudo iptables -t nat -A PREROUTING -i wlan1 -p tcp --dport 80 -j REDIRECT --to-port 8080
sudo iptables -t nat -A PREROUTING -i wlan1 -p tcp --dport 433 -j REDIRECT --to-port 8080

# mitmproxy -T --host

# sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE  
# sudo iptables -A FORWARD -i eth0 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT  
# sudo iptables -A FORWARD -i wlan0 -o eth0 -j ACCEPT