#!/bin/bash

sleep 10
sudo -u student firefox --headless &
sleep 5
sudo -u student pkill firefox

# Evita execução futura
rm -f /etc/systemd/system/init-firefox.service
