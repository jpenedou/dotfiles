#!/bin/bash

# Waybar
pkill waybar$
waybar &

# Load network manager applet
nm-applet --indicator &

# Bluetooth applet
blueman-applet
# blueman-tray
