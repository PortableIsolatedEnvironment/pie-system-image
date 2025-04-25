#!/bin/bash
set -e

systemctl enable init-firefox.service
chmod +x /usr/local/bin/init-firefox.sh
