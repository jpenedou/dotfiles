#!/bin/bash

chassis=$(hostnamectl chassis)

hyprctl keyword input:kb_options caps:escape_shifted_capslock

if [[ $chassis = "laptop" ]]; then
  # kb_options
  hyprctl keyword input:kb_options caps:escape_shifted_capslock,altwin:prtsc_rwin
  hyprctl keyword bind CTRL, SUPER_R, exec, ~/.config/hypr/scripts/screenshot.sh
  hyprctl keyword monitor HDMI-A-1, disable
  hyprctl keyword monitor HDMI-A-2, disable
  hyprctl dispatch workspace 1
else
  # binds
  hyprctl keyword bind ", PRINT, exec, ~/.config/hypr/scripts/screenshot.sh"
fi
