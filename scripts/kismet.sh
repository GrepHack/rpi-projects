#!/bin/bash

## Installing Kismet on RPI ##
wget -O - https://www.kismetwireless.net/repos/kismet-release.gpg.key | sudo apt-key add -
echo 'deb https://www.kismetwireless.net/repos/apt/git/stretch stretch main' | sudo tee /etc/apt/sources.list.d/kismet.list
sudo apt update
