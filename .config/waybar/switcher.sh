#!/bin/bash

# Nombre del proceso a buscar
process_name="hyprswitch"

# Comprobar si el proceso está en ejecución
if pgrep "$process_name" >/dev/null; then
	hyprswitch --stop-daemon
else
	hyprswitch --daemon
fi
