timeswaylock=600
timeoff=660
if [ -f "/usr/bin/swayidle" ]; then
  echo "swayidle is installed."
  # swaylock se instala mediante el paquete swaylock-effects
  swayidle -w timeout $timeswaylock 'swaylock -f' timeout $timeoff 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on'
else
  echo "swayidle not installed."
fi
