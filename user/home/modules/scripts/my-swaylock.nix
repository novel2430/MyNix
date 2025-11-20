{pkgs, opt-config, ...}:
let
  swaylock = "${pkgs.swaylock-effects}/bin/swaylock";
  lock-img = "${opt-config.lock-img}";
  grim_cmd = "${pkgs.grim}/bin/grim";
  ffmpeg = "${pkgs.ffmpeg}/bin/ffmpeg";
in
pkgs.writeShellScriptBin "my-swaylock" ''
  indicator_radius=60
  indicator_thickness=7
  x_pos=$(( $indicator_radius + $indicator_thickness + 10 ))
  y_pos=$(( $indicator_radius + $indicator_thickness + 10 ))
  y_pos=$(( 1080 - $y_pos ))
  b_color="${opt-config.colors.dmenu-background}"
  f_color="${opt-config.colors.focus-background}"
  text_f_color="${opt-config.colors.foreground}"
  wrong_color="bf616a"
  screenshot="/tmp/temp_screenshot.png"
  blur_screenshot="/tmp/temp_screenshot_blur.jpg"
  take_full_and_blur() {
    ${grim_cmd} "''${screenshot}" && \
      ${ffmpeg} -i $screenshot -vf "gblur=sigma=10" $blur_screenshot -y 
  }

  case $1 in
    manual)
      ${swaylock} \
              --ignore-empty-password \
              --screenshots \
              --clock \
              --indicator \
              --indicator-radius $indicator_radius \
              --indicator-thickness $indicator_thickness \
              --effect-blur 7x5 \
              --effect-vignette 0.5:0.5 \
              --ring-color $b_color \
              --ring-ver-color $b_color \
              --ring-clear-color $b_color \
              --ring-wrong-color $wrong_color \
              --key-hl-color $f_color \
              --line-color 00000000 \
              --inside-color 00000088 \
              --inside-ver-color 00000088 \
              --inside-clear-color 00000088 \
              --inside-wrong-color $wrong_color \
              --text-color $text_f_color \
              --text-ver-color $text_f_color \
              --text-clear-color $text_f_color \
              --text-wrong-color $text_f_color \
              --separator-color 00000000
      ;;
    idle)
      take_full_and_blur && ${swaylock} \
              --ignore-empty-password \
              --image $blur_screenshot \
              --clock \
              --indicator \
              --indicator-radius $indicator_radius \
              --indicator-thickness $indicator_thickness \
              --effect-vignette 0.5:0.5 \
              --ring-color $b_color \
              --ring-ver-color $b_color \
              --ring-clear-color $b_color \
              --ring-wrong-color $wrong_color \
              --key-hl-color $f_color \
              --line-color 00000000 \
              --inside-color 00000088 \
              --inside-ver-color 00000088 \
              --inside-clear-color 00000088 \
              --inside-wrong-color $wrong_color \
              --text-color $text_f_color \
              --text-ver-color $text_f_color \
              --text-clear-color $text_f_color \
              --text-wrong-color $text_f_color \
              --separator-color 00000000
      ;;
  esac
''
