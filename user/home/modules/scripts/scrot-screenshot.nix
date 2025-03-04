{pkgs, opt-config, ...}:
let
  scrot_cmd = "${pkgs.scrot}/bin/scrot";
  dunstify_cmd = "${pkgs.dunst}/bin/dunstify";
in
pkgs.writeShellScriptBin "scrot-screenshot" ''
  path="${opt-config.screenshot-dir}"
  now_date=''$(date '+%Y%m%d-%H%M%S')
  file_name="''${path}/''${now_date}.png"
  msg="save as \n''${file_name}"

  mkdir -p $path

  case $1 in
    full)
      ${scrot_cmd} "''${file_name}" && ${dunstify_cmd} -a "Screenshot" "Full" "''${msg}" -r 2003

      ;;
    select)
      ${scrot_cmd} -s "''${file_name}" && ${dunstify_cmd} -a "Screenshot" "Select" "''${msg}" -r 2003
      ;;
  esac
''
