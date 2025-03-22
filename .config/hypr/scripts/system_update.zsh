#!/bin/zsh

command="yay -Syu --combinedupgrade --noconfirm"
success_title="✅ Actualizaciones completadas"
error_title="❌ Actualizaciones fallidas"

# Truncar el comando si es demasiado largo
if [[ ${#command} -gt 40 ]]; then
    truncated_command="${command:0:20}..."
else
    truncated_command="$command"
fi

# Ejecutar el comando
eval "$command"
exit_code=$?

# Enviar notificación con título y comando truncado
if [[ $exit_code -eq 0 ]]; then
    notify-send "$success_title" "$truncated_command"
else
    notify-send "$error_title" "$truncated_command"
fi

echo "Cerrando en 10 segundos..."
sleep 10
