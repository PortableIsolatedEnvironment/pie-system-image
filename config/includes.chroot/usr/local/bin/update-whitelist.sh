#!/bin/bash

# Ficheiro onde a Flutter App escreve os domínios permitidos
WHITELIST_FILE="/etc/iptables/whitelist.txt"

# Limpar as regras atuais da whitelist (mas manter as regras essenciais)
iptables -F OUTPUT

# Reaplicar regras essenciais
iptables -A OUTPUT -o lo -j ACCEPT
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -p udp --dport 53 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 53 -j ACCEPT

# Adicionar os IPs da whitelist
while read -r domain; do
    [[ -z "$domain" || "$domain" == \#* ]] && continue  # Ignorar linhas vazias e comentários
    ip=$(getent ahosts "$domain" | awk '{print $1; exit}')
    if [[ -n "$ip" ]]; then
        iptables -A OUTPUT -p tcp -d "$ip" --dport 80 -j ACCEPT
        iptables -A OUTPUT -p tcp -d "$ip" --dport 443 -j ACCEPT
    fi
done < "$WHITELIST_FILE"

# Guardar as novas regras
iptables-save > /etc/iptables/rules.v4

