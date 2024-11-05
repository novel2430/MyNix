{pkgs, ...}:
let
  wpctl = "${pkgs.wireplumber}/bin/wpctl";
  dunstify = "${pkgs.dunst}/bin/dunstify";
in
pkgs.writeShellScriptBin "my-volume" ''
  sending ()
  {
    volume=$(${wpctl} get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2}')
    volume_scale=$(awk '{print $1*$2*$3/$4}' <<<"''${volume} 100 100 150")
    volume_scale_new=$(printf "%.2f" ''${volume_scale})
    ${dunstify} -a "ChangeVolume" -r 9993 -h int:value:"$volume_scale" -i "Vol $1" "Level : ''${volume_scale_new}%" -t 2000
  }

  case $1 in
    up)
      ${wpctl} set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+ && sending $1
      ;;
    down)
      ${wpctl} set-volume @DEFAULT_AUDIO_SINK@ 5%- && sending $1
      ;;
    mute)
      ${wpctl} set-mute @DEFAULT_AUDIO_SINK@ toggle
      if [[ "$(${wpctl} get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $3}')" = "[MUTED]" ]]; then
        ${dunstify} -a "ChangeVolume" -i "Muted" "MUTE" -t 2000 -r 9993
      else
        sending up
      fi
      ;;
  esac
''
