#!/bin/bash

chassis=$(hostnamectl chassis)

hyprctl keyword input:kb_options caps:escape_shifted_capslock

if [[ $chassis = "laptop" ]]; then
  # kb_options
  hyprctl keyword input:kb_options caps:escape_shifted_capslock,altwin:prtsc_rwin
  hyprctl keyword bind CTRL, SUPER_R, exec, ~/.config/hypr/scripts/screenshot.sh

else
  # binds
  hyprctl keyword bind ", PRINT, exec, ~/.config/hypr/scripts/screenshot.sh"

  # monitors
  hyprctl keyword monitor HDMI-A-1,1920x1080,1080x480,1
  hyprctl keyword monitor HDMI-A-2,1920x1080,0x0,1,transform,1
  hyprctl keyword workspace 1, monitor:HDMI-A-2
  hyprctl keyword workspace 2, monitor:HDMI-A-1
fi
