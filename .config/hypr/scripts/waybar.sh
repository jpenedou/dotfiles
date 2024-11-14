#!/bin/bash

# Waybar
pkill waybar$
waybar &

# Load network manager applet
nm-applet --indicator &

# Bluetooth
blueman-applet &
sleep 5
blueman-tray &
