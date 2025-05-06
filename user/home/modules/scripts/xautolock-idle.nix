{pkgs, opt-config, ...}:
let
  xautolock = "${pkgs.xautolock}/bin/xautolock";
in
pkgs.writeShellScriptBin "xautolock-idle" ''
  ${xautolock} -time ${opt-config.idle.lock-min} -locker "x-lock"
''
