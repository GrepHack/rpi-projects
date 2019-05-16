#!/usr/bin/env bash
echo "Wifi Config Script wlan0, auto-connect/DHCP"
rm wpa_supplicant.conf
printf "ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev \nupdate_config=1\ncountry=FR\n\n" >> wpa_supplicant.conf

while :; do
    read -p "SSID: " ssid
    read -p "key_mgmt (NONE or WPA): " key_mgmt
    read -p "Connection ID, ex: "school" or "home" : " id_str
    read -p "Priority (1 is best): " priority

    if [[ "$key_mgmt" == "WPA" ]]
    then
        read -p "password: " password
        echo Preparing WPA
        network="$(wpa_passphrase $ssid $password)"
        psk=${network: -66:64}
        echo $psk
        printf "network={\r\n    ssid=\"$ssid\"\r\n    key_mgmt=WPA-PSK\r\n    psk=$psk\r\n    priority=$priority\r\n    id_str=\"$id_str\"\r\n}\n\n" >> wpa_supplicant.conf
        printf "\n\nwpa_supplicant.conf configured. please place it in root of SD Card: \n\n\n"
        cat wpa_supplicant.conf
        read -p "More Networks? (or type "e" to exit): "
        [[ "${REPLY}" == "e" ]] && break
    else
        printf "network={\r\n    ssid=\"$ssid\"\r\n    key_mgmt=NONE\r\n    priority=$priority\r\n    id_str=\"$id_str\"\r\n}\n\n" >> wpa_supplicant.conf
        printf "\n\nwpa_supplicant.conf configured. please place it in root of SD Card: \n\n\n"
        cat wpa_supplicant.conf
        read -p "More Networks? (or type "e" to exit): "
        [[ "${REPLY}" == "e" ]] && break
    fi

done