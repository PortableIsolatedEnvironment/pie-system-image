#!/bin/bash

USER_NAME="student"
USER_HOME="/home/$USER_NAME"

echo "Opening Firefox..."

runuser -l "$USER_NAME" -c "DISPLAY=:0 firefox --headless &"
sleep 5

pkill -u "$USER_NAME" firefox
echo "Firefox closed."

