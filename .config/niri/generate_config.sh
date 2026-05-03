#!/bin/bash

# Script para generar el fichero de configuración de niri a partir de perfiles.
# Soporta subdirectorios (ej: dms/).
#
# Los nodos singleton (binds, layout, cursor, etc.) se fusionan automáticamente
# con kdl_merge.py cuando hay colisión: el subdirectorio tiene prioridad.
#
# Uso: ./generate_config.sh <perfil> [subdir1 subdir2 ...]
# Ej:  ./generate_config.sh minikom dms

set -e

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
MERGE_SCRIPT="$SCRIPT_DIR/kdl_merge.py"

if [ -z "$1" ]; then
  echo "Error: Debes proporcionar un nombre de perfil como argumento."
  echo "Uso: $0 <perfil> [subdirs...]"
  echo "Ejemplo: $0 laptop dms"
  exit 1
fi

if ! command -v python3 &>/dev/null; then
  echo "Error: python3 no está disponible."
  exit 1
fi

# Usar virtualenv local para kdl-py si no está disponible en el sistema
VENV_DIR="$SCRIPT_DIR/.venv"
if ! python3 -c "import kdl" &>/dev/null; then
  if [ ! -d "$VENV_DIR" ]; then
    echo "Creando virtualenv e instalando kdl-py..."
    python3 -m venv "$VENV_DIR"
    "$VENV_DIR/bin/pip" install --quiet kdl-py
  fi
  PYTHON="$VENV_DIR/bin/python3"
else
  PYTHON="python3"
fi

PROFILE=$1
shift
SUBDIRS=("$@")

OUTPUT_FILE="$SCRIPT_DIR/config.kdl"
> "$OUTPUT_FILE"

echo "Generando config.kdl para el perfil: $PROFILE"
[ ${#SUBDIRS[@]} -gt 0 ] && echo "Subdirectorios: ${SUBDIRS[*]}"

# Añade un archivo KDL directamente al output (sin fusión)
append_file() {
  local file="$1"
  local label="$2"
  echo "// From: $label" >> "$OUTPUT_FILE"
  cat "$file" >> "$OUTPUT_FILE"
  printf "\n\n" >> "$OUTPUT_FILE"
}

# Fusiona un archivo KDL en el output ya generado (usando kdl_merge.py)
merge_file() {
  local file="$1"
  local label="$2"
  echo "  → Fusionando: $label"
  $PYTHON "$MERGE_SCRIPT" "$OUTPUT_FILE" "$file"
}

# Procesa los archivos KDL de un directorio.
# Si un archivo define un nodo singleton que ya existe en el output, fusiona.
# Si no, añade directamente.
process_dir() {
  local dir="$1"
  local prefix="$2"

  find "$dir" -maxdepth 1 -type f -name "*.kdl" ! -name "config.kdl" | sort | while read -r file; do
    local filename
    filename=$(basename "$file")

    # Determinar si aplica al perfil actual
    local applies=false
    if [[ "$filename" =~ \.([^.]+)\.kdl$ ]]; then
      local file_profile="${BASH_REMATCH[1]}"
      if [ "$file_profile" = "$PROFILE" ]; then
        applies=true
      else
        echo "Ignorando (otro perfil): ${prefix}${filename}"
        continue
      fi
    elif [[ "$filename" =~ \.kdl$ ]]; then
      applies=true
    fi

    if ! $applies; then
      continue
    fi

    # Detectar si el archivo contiene algún nodo singleton que ya está en el output
    local needs_merge=false
    for singleton in binds layout cursor recent-windows input environment animations gestures hotkey-overlay; do
      if grep -qE "^\s*${singleton}\s*\{" "$file" 2>/dev/null && \
         grep -qE "^\s*${singleton}\s*\{" "$OUTPUT_FILE" 2>/dev/null; then
        needs_merge=true
        break
      fi
    done

    if $needs_merge; then
      echo "Fusionando (singleton): ${prefix}${filename}"
      merge_file "$file" "${prefix}${filename}"
    else
      echo "Añadiendo: ${prefix}${filename}"
      append_file "$file" "${prefix}${filename}"
    fi
  done
}

echo -e "\n=== Archivos base ==="
process_dir "$SCRIPT_DIR" ""

for subdir in "${SUBDIRS[@]}"; do
  local_path="$SCRIPT_DIR/$subdir"
  if [ -d "$local_path" ]; then
    echo -e "\n=== Subdirectorio: $subdir/ ==="
    process_dir "$local_path" "$subdir/"
  else
    echo "Advertencia: '$subdir' no existe, saltando."
  fi
done

echo -e "\n¡Hecho! config.kdl generado."
