#!/bin/bash
entries="Logout Suspend Reboot Shutdown"
selected=$(printf '%s\n' $entries | wofi --conf=$HOME/.config/hypr/scripts/power/config.power )

case $selected in
  logout)
    swaymsg exit;;
  suspend)
    exec systemctl suspend;;
  reboot)
    exec systemctl reboot;;
  shutdown)
    exec systemctl poweroff -i;;
esac
