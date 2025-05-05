{pkgs, ...}:
let
  rofi = "${pkgs.rofi}/bin/rofi";
  greenclip = "${pkgs.haskellPackages.greenclip}/bin/greenclip";
in
pkgs.writeShellScriptBin "greenclip-rofi" ''
  ${rofi} -modi "clipboard:${greenclip} print" -show clipboard -run-command '{cmd}'
''
