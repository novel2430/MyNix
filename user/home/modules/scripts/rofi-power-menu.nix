{pkgs, opt-config, ...}:
pkgs.writeShellScriptBin "rofi-power-menu" ''
  reboot_menu="Reboot"
  shutdown_menu="Shutdown"
  lock_menu="Lock"
  logout_menu="Logout"
  res=$(printf '%s\n%s\n%s\n%s' $reboot_menu $shutdown_menu $lock_menu $logout_menu | ${pkgs.rofi}/bin/rofi -dmenu -i)

  if [ $res = $reboot_menu ]; then
    ${pkgs.systemd}/bin/reboot
  elif [ $res = $shutdown_menu ]; then
    ${pkgs.systemd}/bin/poweroff
  elif [ $res = $lock_menu ]; then
    x-lock
  elif [ $res = $logout_menu ]; then
    ${pkgs.systemd}/bin/loginctl terminate-user ${opt-config.username}
  fi
''
