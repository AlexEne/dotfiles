#!/bin/bash
CHOICE=$(printf "Lock\nSuspend\nHibernate\nReboot\nShutdown\nCancel" | walker --dmenu -p "Power" --width 200 --maxheight 300 --minheight 150)
case "$CHOICE" in
  Lock)     hyprlock ;;
  Suspend)  systemctl suspend ;;
  Hibernate) systemctl hibernate ;;
  Reboot)   systemctl reboot ;;
  Shutdown) systemctl poweroff ;;
esac
