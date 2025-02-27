{pkgs, ...}:
let
  systemctl = "${pkgs.systemd}/bin/systemctl";
  dunstify = "${pkgs.dunst}/bin/dunstify";
in
pkgs.writeShellScriptBin "my-bluetooth" ''
  sending ()
  {
    ${dunstify} -a "Blutooth" -r 9994 "Bluetooth $1" -t 2000
  }

  case $1 in
    on)
      ${systemctl} restart --user blueman-applet.service && sending $1
      ;;
    off)
      ${systemctl} stop --user blueman-applet.service && sending $1
      ;;
  esac
''
