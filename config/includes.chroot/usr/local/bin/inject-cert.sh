#!/bin/bash

USER_NAME="student"
USER_HOME="/home/$USER_NAME"
CERT_PATH="$USER_HOME/.mitmproxy/mitmproxy-ca-cert.pem"
FIREFOX_DIR="$USER_HOME/.mozilla/firefox"

command -v certutil >/dev/null 2>&1 || { echo "certutil não está instalado."; exit 1; }

if [ -d "$FIREFOX_DIR" ]; then
    if [ -f "$FIREFOX_DIR/profiles.ini" ]; then
        profiles=$(awk -F= '/^Path=/{print $2}' "$FIREFOX_DIR/profiles.ini")
        for profile in $profiles; do
            PROFILE_PATH="$FIREFOX_DIR/$profile"
            echo "Adicionar certificado ao perfil: $PROFILE_PATH"
            runuser -l "$USER_NAME" -c "certutil -A -n 'mitmproxy' -t 'C,,' -i '$CERT_PATH' -d sql:'$PROFILE_PATH'"
        done
    else
        echo "File profiles.ini não encontrado."
    fi
else
    echo "diretorio do Firefox não encontrado."
fi

