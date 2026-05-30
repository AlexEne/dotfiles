#!/bin/bash
CHOICE=$(printf "Lock\nSuspend\nHibernate\nReboot\nShutdown\nCancel" | rofi -dmenu -i -p "Power" -theme-str 'window { width: 280px; } listview { lines: 6; }')
case "$CHOICE" in
  Lock)     hyprlock ;;
  Suspend)  systemctl suspend ;;
  Hibernate) systemctl hibernate ;;
  Reboot)   systemctl reboot ;;
  Shutdown) systemctl poweroff ;;
esac
