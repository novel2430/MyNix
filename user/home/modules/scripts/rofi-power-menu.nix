{pkgs, opt-config, ...}:
pkgs.writeShellScriptBin "rofi-power-menu" ''
  reboot_menu="Reboot"
  shutdown_menu="Shutdown"
  lock_menu="Lock"
  logout_menu="Logout"
  res=$(printf '%s\n%s\n%s\n%s' $reboot_menu $shutdown_menu $lock_menu $logout_menu | ${pkgs.rofi-wayland}/bin/rofi -dmenu -i)
  WAYLAND_DISPLAY=$(cat /home/${opt-config.username}/.wm_state)

  if [ $res = $reboot_menu ]; then
    ${pkgs.systemd}/bin/reboot
  elif [ $res = $shutdown_menu ]; then
    ${pkgs.systemd}/bin/poweroff
  elif [ $res = $lock_menu ]; then
    if [ -z "$WAYLAND_DISPLAY" ]; then
      my-swaylock idle
    elif [ "$WAYLAND_DISPLAY" == "X11" ]; then
      x-lock
    else
      my-swaylock idle
    fi
  elif [ $res = $logout_menu ]; then
    ${pkgs.systemd}/bin/loginctl terminate-user ${opt-config.username}
  fi
''
