#!/bin/bash

mode="drun"

if [ -n "$1" ]; then
  mode=$1
fi

# Verificar si Rofi está en ejecución
if pgrep -x "rofi" >/dev/null; then
  # Matar Rofi si está en ejecución
  pkill rofi
fi

# Iniciar Rofi
rofi -show "$mode" -theme-str 'window {location: center;}' &
