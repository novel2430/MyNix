{ pkgs, opt-config, custom-pkgs, ... }:
with pkgs;
rec {
  swaylock-path = import ../scripts/my-swaylock.nix {
    inherit pkgs;
    inherit opt-config;
  };
  wlroot-clipboard-path = import ../scripts/wlroot-clipboard.nix {
    inherit pkgs;
  };
  wofi-power-menu-path = import ../scripts/wofi-power-menu.nix {
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

  # Define paths to custom and standard applications
  apps = {
    foot = "${pkgs.foot}/bin/foot";
    brightnessctl = "${brightnessctl}/bin/brightnessctl";
    wofi = "${wofi}/bin/wofi";
    fuzzel = "${fuzzel}/bin/fuzzel";
    wlrootsClipboard = "${wlroot-clipboard-path}/bin/wlroot-clipboard";
    swaylock = "${swaylock-path}/bin/my-swaylock";
    powerMenu = "${wofi-power-menu-path}/bin/wofi-power-menu";
    volume = "${my-volume-path}/bin/my-volume";
    wpctl = "${pkgs.wireplumber}/bin/wpctl";
    screenshot = "${screenshot-path}/bin/grim-slurp-screenshot";
    browser = "${pkgs.nur.repos.novel2430.zen-browser-bin}/bin/zen-browser";
    fuzzyMarks = "${pkgs.nur.repos.novel2430.FuzzyMarks}/bin/fuzzyMarks";
    playerctl = "${pkgs.playerctl}/bin/playerctl";
  };
  # Define keybindings
  keybindings = {
    basic = [
      # Close focused view
      { modes = ["normal"]; keys = "Super Q"; action = "close"; }
      # Exit river
      { modes = ["normal"]; keys = "Super+Shift E"; action = "exit"; }
      # Layout navigation
      { modes = ["normal"]; keys = "Super J"; action = "focus-view next"; }
      { modes = ["normal"]; keys = "Super K"; action = "focus-view previous"; }
      { modes = ["normal"]; keys = "Super+Shift J"; action = "swap next"; }
      { modes = ["normal"]; keys = "Super+Shift K"; action = "swap previous"; }
      { modes = ["normal"]; keys = "Super+Shift Return"; action = "zoom"; }
      { modes = ["normal"]; keys = "Super H"; action = "send-layout-cmd rivercarro 'main-ratio -0.05'"; }
      { modes = ["normal"]; keys = "Super L"; action = "send-layout-cmd rivercarro 'main-ratio +0.05'"; }
      # Fullscreen and floating toggle
      { modes = ["normal"]; keys = "Super F"; action = "toggle-fullscreen"; }
      { modes = ["normal"]; keys = "Super+Shift Space"; action = "toggle-float"; }
      # Change Layout
      { modes = ["normal"]; keys = "Super M"; action = "send-layout-cmd rivercarro 'main-location-cycle left,monocle'"; }
      { modes = ["normal"]; keys = "Super+Shift M"; action = "send-layout-cmd rivercarro 'main-location-cycle left,top,right,bottom,monocle'"; }
    ];
    apps = [
      # Terminal
      { modes = ["normal"]; keys = "Super Return"; action = "${apps.foot}"; }
      # Custom application bindings
      { modes = ["normal"]; keys = "Super D"; action = "${apps.wofi} --show drun"; }
      { modes = ["normal"]; keys = "Super R"; action = "${apps.wofi} --show run"; }
      { modes = ["normal"]; keys = "Super+Shift F"; action = "${apps.browser}"; }
      { modes = ["normal"]; keys = "Super C"; action = "${apps.wlrootsClipboard}"; }
      { modes = ["normal"]; keys = "Super+Shift L"; action = "${apps.swaylock} manual"; }
      { modes = ["normal"]; keys = "Super+Shift P"; action = "${apps.powerMenu}"; }
      # Volume control
      { modes = ["normal" "locked"]; keys = "None XF86AudioRaiseVolume"; action = "${apps.wpctl} set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"; }
      { modes = ["normal" "locked"]; keys = "None XF86AudioLowerVolume"; action = "${apps.wpctl} set-volume @DEFAULT_AUDIO_SINK@ 5%-"; }
      { modes = ["normal" "locked"]; keys = "None XF86AudioMute"; action = "${apps.wpctl} set-mute @DEFAULT_AUDIO_SINK@ toggle"; }
      # Brightness control
      { modes = ["normal" "locked"]; keys = "None XF86MonBrightnessUp"; action = "${apps.brightnessctl} set +10%"; }
      { modes = ["normal" "locked"]; keys = "None XF86MonBrightnessDown"; action = "${apps.brightnessctl} set 10%-"; }
      # Audio control
      { modes = ["normal"]; keys = "None XF86AudioPlay"; action = "${apps.playerctl} play-pause"; }
      { modes = ["normal"]; keys = "None XF86AudioNext"; action = "${apps.playerctl} next"; }
      { modes = ["normal"]; keys = "None XF86AudioPrev"; action = "${apps.playerctl} previous"; }
      # Screenshot
      { modes = ["normal" "locked"]; keys = "None Print"; action = "${apps.screenshot} full"; }
      { modes = ["normal"]; keys = "Super Print"; action = "${apps.screenshot} select"; }
      # Reload Config
      { modes = ["normal"]; keys = "Super+Shift R"; action = "~/.config/river/init reload"; }
      # FuzzyMarks
      { modes = ["normal"]; keys = "Super N"; action = "${apps.fuzzyMarks}"; }
    ];
    pointer = [
      { keys = "Super BTN_LEFT"; action = "move-view"; }
      { keys = "Super BTN_RIGHT"; action = "resize-view"; }
    ];
  };
  # Define View Rules
  view-rules = {
    # Force Floating
    floating = [
      {app-id = "float*"; title = "foo";}
      {app-id = "wemeetapp";}
      {app-id = "com.alibabainc.dingtalk";}
    ];
    # Force Csd
    csd = [
      {app-id = "bar";}
      {app-id = "wemeetapp";}
    ];
    # Force Ssd
    ssd = [
      {app-id = "brave-browser";}
      {app-id = "nemo";}
      {app-id = "org.pulseaudio.pavucontrol";}
      {app-id = "gedit";}
      {app-id = "com.alibabainc.dingtalk";}
      {app-id = "org.jackhuang.hmcl.Launcher";}
      {app-id = "Motrix";}
      {app-id = "wechat";}
      {app-id = "com.github.weclaw1.ImageRoll";}
      {app-id = "pdf";}
      {app-id = "wps";}
      {app-id = "wpp";}
      {app-id = "net.lutris.Lutris";}
      {app-id = "io.github.celluloid_player.Celluloid";}
      {app-id = "steam";}
      {app-id = "org.pwmt.zathura";}
      {app-id = "io.bassi.Amberol";}
      {app-id = "zen";}
      {app-id = "com.mitchellh.ghostty";}
      {app-id = "emacs";}
    ];
  };
  # Define Gaps
  gaps = {
    smart-gap = false;
    inner = "0";
    outer = "0";
  };
  # Define Keyboard Repeat Rate
  keyboard-repeat = {
    rate = "50";
    delay = "300";
  };
  # Define Tags Operation
  tags = {
    count = 9;
    keybindings = {
      set-focused-tags = "Super";
      set-view-tags = "Super+Shift";
      toggle-focused-tags = "Super+Control";
      all-tags = "Super 0";
    };
  };
  # Define Background and Border
  background-border-settings = {
    background-color = "0x002b36";
    border-color-focused = "0xe0deda";
    border-color-unfocused = "0x1c2e36";
    border-width = "2";
  };
}
