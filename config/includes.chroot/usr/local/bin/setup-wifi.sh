#!/bin/bash

WIFI_SSID="user"
WIFI_PSK="password"

UUID=$(uuidgen)

CONFIG_FILE="/etc/NetworkManager/system-connections/WiFiAuto.nmconnection"

cat <<EOF > "$CONFIG_FILE"
[connection]
id=$WIFI_SSID
uuid=$UUID
type=wifi
autoconnect=true

[wifi]
ssid=$WIFI_SSID
mode=infrastructure
mac-address-blacklist=

[wifi-security]
key-mgmt=wpa-psk
psk=$WIFI_PSK

[ipv4]
method=auto

[ipv6]
method=auto
EOF

chmod 600 "$CONFIG_FILE"

systemctl restart NetworkManager
