#!/bin/bash
set -e

systemctl enable init-mitmproxy.service
chmod +x /usr/local/bin/init-mitmproxy.sh
