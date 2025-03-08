#!/bin/bash

set -x

# Permitir tráfego na interface de loopback
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# Permitir tráfego de entrada relacionado a conexões estabelecidas
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Permitir tráfego ICMP (ping e alguns serviços internos precisam disto)
iptables -A INPUT -p icmp -j ACCEPT

# Permitir tráfego DNS (necessário para resolver domínios)
iptables -A OUTPUT -p udp --dport 53 -j ACCEPT
iptables -A OUTPUT -p tcp --dport 53 -j ACCEPT

# Permitir DHCP (caso a rede seja dinâmica)
iptables -A INPUT -p udp --sport 67 --dport 68 -j ACCEPT
iptables -A OUTPUT -p udp --sport 68 --dport 67 -j ACCEPT

# (Opcional) Permitir SSH para acesso remoto (comenta se não for necessário)
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -j ACCEPT

# Definir política padrão para bloquear tudo (temporariamente comentado para adicionar regras essenciais)
iptables -P INPUT DROP
iptables -P OUTPUT DROP
iptables -P FORWARD DROP




# Criar um ficheiro para armazenar os IPs permitidos (inicialmente vazio)
echo "# IPs permitidos" > /etc/iptables/whitelist.txt

# Guardar regras iniciais (sem whitelist)
iptables-save > /etc/iptables/rules.v4


