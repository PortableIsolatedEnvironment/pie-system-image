#!/bin/bash

set -e

WHITELIST_FILE="/etc/iptables/whitelist.txt"

ip=$(cat /etc/pie-devapp/config.json | python3 -c "import sys, json; print(json.load(sys.stdin)['apiBaseUrl'])" | awk -F'//' '{print $2}' | awk -F':' '{print $1}')
port=$(cat /etc/pie-devapp/config.json | python3 -c "import sys, json; print(json.load(sys.stdin)['apiBaseUrl'])" | awk -F'//' '{print $2}' | awk -F':' '{print $2}')

iptables -F OUTPUT

iptables -A OUTPUT -o lo -j ACCEPT
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -p udp --dport 53 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 53 -j ACCEPT

iptables -A INPUT -p tcp -s "$ip" -j ACCEPT
iptables -A OUTPUT -p tcp -d "$ip" -j ACCEPT


while read -r domain; do
    [[ -z "$domain" || "$domain" == \#* ]] && continue  # Ignorar linhas vazias e comentários
    ip=$(getent ahosts "$domain" | awk '{print $1; exit}')
    if [[ -n "$ip" ]]; then
        iptables -A OUTPUT -p tcp -d "$ip" --dport 80 -j ACCEPT
        iptables -A OUTPUT -p tcp -d "$ip" --dport 443 -j ACCEPT
    fi
done < "$WHITELIST_FILE"

iptables-save > /etc/iptables/rules.v4
