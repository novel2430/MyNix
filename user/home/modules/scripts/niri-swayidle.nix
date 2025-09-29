{pkgs, opt-config, ...}:
let
  wlopm = "${pkgs.wlopm}/bin/wlopm";
  swayidle = "${pkgs.swayidle}/bin/swayidle";
  my-swaylock = import ./my-swaylock.nix {
    inherit pkgs;
    inherit opt-config;
  };
  swaylock = "${my-swaylock}/bin/my-swaylock";
  niri = "${pkgs.niri}/bin/niri";
in
pkgs.writeShellScriptBin "niri-swayidle" ''
  dpms_off_cmd="${niri} msg action power-off-monitors"
  dpms_on_cmd="${niri} msg action power-on-monitors"
  lock_cmd="${swaylock} idle &"

  ${swayidle} -w \
    timeout ${opt-config.idle.dpms-standby} "''${dpms_off_cmd}" \
      resume "''${dpms_on_cmd}"
''
