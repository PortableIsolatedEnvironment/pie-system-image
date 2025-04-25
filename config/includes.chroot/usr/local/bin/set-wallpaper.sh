#!/bin/bash

sleep 5

# Set this to your desired wallpaper path
WALLPAPER_PATH="/usr/share/images/wallpapers/Image.png"

# Find workspace config path in xfce4-desktop
path=$(xfconf-query --channel xfce4-desktop --list | grep workspace0/last-image)

# Set the wallpaper
xfconf-query --channel xfce4-desktop --property "$path" --set "$WALLPAPER_PATH"
