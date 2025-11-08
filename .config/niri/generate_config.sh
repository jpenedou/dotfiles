#!/bin/bash

# Script para generar el fichero de configuración de niri a partir de perfiles.

set -e

if [ -z "$1" ]; then
  echo "Error: Debes proporcionar un nombre de perfil como argumento."
  echo "Uso: $0 <perfil>"
  exit 1
fi

PROFILE=$1
CONFIG_DIR=$(cd "$(dirname "$0")" && pwd)
OUTPUT_FILE="$CONFIG_DIR/config.kdl"

# Limpiar el fichero de configuración existente
> "$OUTPUT_FILE"

echo "Generando config.kdl para el perfil: $PROFILE"

# Procesar todos los ficheros .kdl en el directorio
# Usamos -maxdepth 1 para no entrar en subdirectorios.
find "$CONFIG_DIR" -maxdepth 1 -type f -name "*.kdl" ! -name "config.kdl" | sort | while read -r file; do
  filename=$(basename "$file")

  # Comprobar si el fichero es específico de un perfil (ej: 'input.laptop.kdl')
  if [[ "$filename" =~ \.([^.]+)\.kdl$ ]]; then
    file_profile="${BASH_REMATCH[1]}"
    if [ "$file_profile" == "$PROFILE" ]; then
      echo "Añadiendo (específico de perfil): $filename"
      echo "// From: $filename" >> "$OUTPUT_FILE"
      cat "$file" >> "$OUTPUT_FILE"
      echo -e "\n" >> "$OUTPUT_FILE"
    else
      echo "Ignorando (otro perfil): $filename"
    fi
  # Comprobar si es un fichero genérico (ej: 'binds.kdl')
  elif [[ "$filename" =~ \.kdl$ ]]; then
    echo "Añadiendo (genérico): $filename"
    echo "// From: $filename" >> "$OUTPUT_FILE"
    cat "$file" >> "$OUTPUT_FILE"
    echo -e "\n" >> "$OUTPUT_FILE"
  fi
done

echo "¡Hecho! El fichero config.kdl ha sido generado."