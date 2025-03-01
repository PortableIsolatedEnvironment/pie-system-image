#!/bin/bash

# Definir a configuração da Wi-Fi
WIFI_SSID="NomeDaRede"
WIFI_PSK="senha"

# Gerar um UUID aleatório para a configuração
UUID=$(uuidgen)

# Criar o ficheiro de configuração para o NetworkManager
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

# Definir permissões corretas
chmod 600 "$CONFIG_FILE"

# Reiniciar o NetworkManager para aplicar a configuração
systemctl restart NetworkManager

