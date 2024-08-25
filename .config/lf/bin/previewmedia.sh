#!/usr/bin/env bash

filePath=$1
width=$2
height=$3

cache="$HOME/.cache"

# mkdir -p "$cache"
minimumWidth=40
resizedImagesWidth=800

# width=$(expr $width - 50)
# if [ $width -lt $minimumWidth ]; then
# 	width=$minimumWidth
# fi

# height=$(expr $height - 40)

if [ ! -r "$filePath" ]; then
  echo "No hay permisos de lectura"
  exit 1
fi

mimeType=$(file -Lb --mime-type "$filePath")
mimeEncoding=$(file -Lb --mime-encoding "$filePath")

if [[ "$mimeType" == *"image"* ]]; then
  kitty +kitten icat --silent --stdin no --transfer-mode file --place "${width}x${height}@${4}x${5}" "$filePath" </dev/null >/dev/tty
  exit 1
elif [[ "$mimeType" == *"video"* ]]; then
  thumb=$(/home/japenedo/.config/lf/bin/vidthumb "$filePath")
  kitty +kitten icat --silent --stdin no --transfer-mode file --place "${width}x${height}@${4}x${5}" "$thumb" </dev/null >/dev/tty
  exit 1
elif [[ "$mimeType" == *"pdf"* ]]; then
  thumb="$cache/lf.gs.png"
  gs -o "$thumb" -sDEVICE=png16m -r150 -dLastPage=1 "$filePath" >/dev/null
  kitty +kitten icat --silent --stdin no --transfer-mode file --place "${width}x${height}@${4}x${5}" "$thumb" </dev/null >/dev/tty
  exit 1
elif [[ "$mimeType" == *"word"* ]]; then
  tempPdf="$cache/lf.unoconv.pdf"
  thumb="$cache/lf.unoconv.png"
  unoconv -f pdf -e PageRange=1 -o "$tempPdf" "$filePath"
  # convert $tempPdf $thumb
  gs -o "$thumb" -sDEVICE=png16m -r150 -dLastPage=1 "$tempPdf" >/dev/null
  kitty +kitten icat --silent --stdin no --transfer-mode file --place "${width}x${height}@${4}x${5}" "$thumb" </dev/null >/dev/tty
  exit 1
elif [[ "$mimeEncoding" != "binary" && "$mimeEncoding" != "utf-8" && "$mimeEncoding" != *"ascii"* ]]; then
  tempiconv="$cache/lf.iconv"
  iconv -f "$mimeEncoding" "$filePath" -o "$tempiconv"
  filePath="$tempiconv"
fi

# Instalar pistol con: go install github.com/doronbehar/pistol/cmd/pistol@latest
~/go/bin/pistol "$filePath"
# exit 1

# echo Fin previewmedia
