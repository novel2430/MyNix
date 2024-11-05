{pkgs, ...}:
let
  wlopm = "${pkgs.wlopm}/bin/wlopm";
  swayidle = "${pkgs.swayidle}/bin/swayidle";
in
pkgs.writeShellScriptBin "my-swayidle" ''
  dpms_off_cmd="${wlopm} --off HDMI-A-1 ; ${wlopm} --off eDP-1; ${wlopm} --off VGA-1; ${wlopm} --off LVDS-1; ${wlopm} --off HDMI-A-2"
  dpms_on_cmd="${wlopm} --on HDMI-A-1 ; ${wlopm} --on eDP-1; ${wlopm} --on VGA-1; ${wlopm} --on LVDS-1; ${wlopm} --on HDMI-A-2"
  lock_cmd="my-swaylock idle &"

  ${swayidle} -w \
    timeout 1200 "''${dpms_off_cmd}" \
      resume "''${dpms_on_cmd}" \
    timeout 3600 "''${lock_cmd}" \
      resume "''${dpms_on_cmd}"
''
