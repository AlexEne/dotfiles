# Overwrite parts of the omarchy-menu with user-specific submenus.
# See $OMARCHY_PATH/bin/omarchy-menu for functions that can be overwritten.
#
# WARNING: Overwritten functions will obviously not be updated when Omarchy changes.
#
# Example of minimal system menu:
#
# show_system_menu() {
#   case $(menu "System" "  Lock\n󰐥  Shutdown") in
#   *Lock*) omarchy-lock-screen ;;
#   *Shutdown*) omarchy-cmd-shutdown ;;
#   *) back_to show_main_menu ;;
#   esac
# }

# Override screenrecord menu to use noctalia's recording widget
#show_screenrecord_menu() {
#  # Check if noctalia is running
#  if ! pgrep -f "qs -c noctalia-shell" >/dev/null; then
#    # Fallback to omarchy's built-in recording if noctalia isn't running
#    if pgrep -f "^gpu-screen-recorder" >/dev/null; then
#      omarchy-cmd-screenrecord
#    else
#      omarchy-cmd-screenrecord --with-desktop-audio
#    fi
#    return
#  fi
#  
#  # Use noctalia's screen recording plugin via IPC
#  qs -c noctalia-shell ipc call plugin:screen-recorder toggle
#}
