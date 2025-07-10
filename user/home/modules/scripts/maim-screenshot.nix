{pkgs, opt-config, ...}:
let
  maim_cmd = "${pkgs.maim}/bin/maim";
  dunstify_cmd = "${pkgs.dunst}/bin/dunstify";
in
pkgs.writeShellScriptBin "maim-screenshot" ''
  path="${opt-config.screenshot-dir}"
  now_date=''$(date '+%Y%m%d-%H%M%S')
  file_name="''${path}/''${now_date}.png"
  msg="save as \n''${file_name}"

  mkdir -p $path

  case $1 in
    full)
      ${maim_cmd} "''${file_name}" && ${dunstify_cmd} -a "Screenshot" "Full" "''${msg}" -r 2003

      ;;
    select)
      ${maim_cmd} -s "''${file_name}" && ${dunstify_cmd} -a "Screenshot" "Select" "''${msg}" -r 2003
      ;;
  esac
''
