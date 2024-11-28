{pkgs, opt-config,  ...}:
pkgs.writeShellScriptBin "start-wm" ''
  echo "$1" > /home/${opt-config.username}/.wm_state
''
