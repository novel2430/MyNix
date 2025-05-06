{pkgs, opt-config, ...}:
let
  xset = "${pkgs.xorg.xset}/bin/xset";
in
pkgs.writeShellScriptBin "xset-dpms" ''
  ${xset} dpms ${opt-config.idle.dpms-standby} ${opt-config.idle.dpms-off} ${opt-config.idle.dpms-off} 
''
