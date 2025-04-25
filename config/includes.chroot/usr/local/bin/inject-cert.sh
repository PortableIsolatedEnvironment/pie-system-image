#!/bin/bash

echo "Script iniciado: $(date)" >> /tmp/inject-certs.log
sleep 5

sleep 5 
echo "Injetando certificados..." >> /tmp/inject.log



# Path to mitmproxy certificate
CERT_PATH=~/.mitmproxy/mitmproxy-ca-cert.pem

# Check if the profiles directory exists (indicating Firefox has been run before)
if [ -d ~/.mozilla/firefox ]; then
    # Check if the profiles.ini file exists (it will be created after the first run)
    if [ -f ~/.mozilla/firefox/profiles.ini ]; then
        # Loop over all profile directories in firefox
        for profile in ~/.mozilla/firefox/*.default*; do
            # Add mitmproxy certificate to each profile
            certutil -A -n "mitmproxy" -t "C,," -i "$CERT_PATH" -d sql:"$profile"
        done
        echo "Mitmproxy certificate added to Firefox profiles."
    else
        echo "Profiles not created yet, Firefox has not been run."
    fi
else
    echo "Firefox profiles directory does not exist. Firefox has not been run."
fi
