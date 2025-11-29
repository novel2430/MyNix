{config, pkgs, custom-pkgs, lib, opt-config, ...}:
let
  swaylock-path = import ../scripts/my-swaylock.nix {
    inherit pkgs;
    inherit opt-config;
  };
  wlroot-clipboard-path = import ../scripts/wlroot-clipboard.nix {
    inherit pkgs;
  };
  rofi-power-menu-path = import ../scripts/rofi-power-menu.nix {
    inherit pkgs;
    inherit opt-config;
  };
  my-volume-path = import ../scripts/volume.nix {
    inherit pkgs;
  };
  screenshot-path = import ../scripts/grim-slurp-screenshot.nix {
    inherit pkgs;
    inherit opt-config;
  };
  apps = with pkgs; {
    terminal = "${foot}/bin/foot";
    dmenu = "${rofi}/bin/rofi -show drun";
    rmenu = "${rofi}/bin/rofi -show run";
    browser = "${nur.repos.novel2430.zen-browser-bin}/bin/zen-browser";
    brightnessctl = "${brightnessctl}/bin/brightnessctl";
    wlrootsClipboard = "${wlroot-clipboard-path}/bin/wlroot-clipboard";
    swaylock = "${swaylock-path}/bin/my-swaylock";
    powerMenu = "${rofi-power-menu-path}/bin/rofi-power-menu";
    volume = "${my-volume-path}/bin/my-volume";
    wpctl = "${pkgs.wireplumber}/bin/wpctl";
    screenshot = "${screenshot-path}/bin/grim-slurp-screenshot";
    playerctl = "${pkgs.playerctl}/bin/playerctl";
  };
in
{
  home.file.".config/sway/keybind" = with apps; {
    text = ''
      bindsym Mod4+Return exec ${terminal}
      bindsym Mod4+d exec ${dmenu}
      bindsym Mod4+r exec ${rmenu}
      bindsym Mod4+Shift+f exec ${browser}
      bindsym Mod4+c exec ${wlrootsClipboard}
      bindsym Mod4+Shift+l exec ${swaylock} idle
      bindsym Mod4+Shift+p exec ${powerMenu}
      bindsym XF86AudioRaiseVolume exec ${volume} up
      bindsym XF86AudioLowerVolume exec ${volume} down
      bindsym XF86AudioMute exec ${volume} mute
      bindsym XF86MonBrightnessUp exec ${brightnessctl} set +10%
      bindsym XF86MonBrightnessDown exec ${brightnessctl} set 10%-
      bindsym XF86AudioPlay exec ${playerctl} play-pause
      bindsym XF86AudioNext exec ${playerctl} next
      bindsym XF86AudioPrev exec ${playerctl} previous
      bindsym Print exec ${screenshot} full
      bindsym Mod4+Print exec ${screenshot}
      bindsym Mod4+Shift+s exec ${screenshot}
    '';
  };
}
