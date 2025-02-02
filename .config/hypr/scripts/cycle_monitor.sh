#!/bin/bash

# Obtener el ID del monitor actual
current=$(hyprctl monitors -j | jq '.[] | select(.focused == true).id')

# Obtener el número total de monitores
total=$(hyprctl monitors -j | jq 'length')

if [ "$1" == "next" ]; then
  next=$(((current + 1) % total))
elif [ "$1" == "previous" ]; then
  next=$(((current - 1 + total) % total))
else
  echo "Uso: $0 next | previous"
  exit 1
fi

# Cambiar al monitor correspondiente
hyprctl dispatch focusmonitor $next
