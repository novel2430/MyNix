{ pkgs, ... }:
with pkgs;
rec {
  # Define paths to custom and standard applications
  apps = {
    foot = "${foot}/bin/foot";
    brightnessctl = "${brightnessctl}/bin/brightnessctl";
    wofi = "${wofi}/bin/wofi";
    wlrootsClipboard = "wlroot-clipboard";
    swaylock = "my-swaylock";
    powerMenu = "wofi-power-menu";
    volume = "my-volume";
    screenshot = "grim-slurp-screenshot";
    browser = "brave --enable-features=UseOzonePlatform --ozone-platform=wayland --gtk-version=4";
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
      { modes = ["normal"]; keys = "Super Space"; action = "toggle-float"; }
      # Change Layout
      { modes = ["normal"]; keys = "Super M"; action = "send-layout-cmd rivercarro 'main-location monocle'"; }
      { modes = ["normal"]; keys = "Super+Shift M"; action = "send-layout-cmd rivercarro 'main-location left'"; }
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
      { modes = ["normal" "locked"]; keys = "None XF86AudioRaiseVolume"; action = "${apps.volume} up"; }
      { modes = ["normal" "locked"]; keys = "None XF86AudioLowerVolume"; action = "${apps.volume} down"; }
      { modes = ["normal" "locked"]; keys = "None XF86AudioMute"; action = "${apps.volume} mute"; }
      # Brightness control
      { modes = ["normal" "locked"]; keys = "None XF86MonBrightnessUp"; action = "${apps.brightnessctl} set +10%"; }
      { modes = ["normal" "locked"]; keys = "None XF86MonBrightnessDown"; action = "${apps.brightnessctl} set 10%-"; }
      # Screenshot
      { modes = ["normal" "locked"]; keys = "None Print"; action = "${apps.screenshot} full"; }
      { modes = ["normal"]; keys = "Super Print"; action = "${apps.screenshot} select"; }
      # Reload Config
      { modes = ["normal"]; keys = "Super+Shift R"; action = "~/.config/river/init reload"; }
    ];
  };
  # Define View Rules
  view-rules = {
    # Force Floating
    floating = [
      {app-id = "float*"; title = "foo";}
    ];
    # Force Csd
    csd = [
      {app-id = "bar";}
    ];
  };
  # Define Gaps
  gaps = {
    smart-gap = false;
    inner = "10";
    outer = "20";
  };
  # Define Keyboard Repeat Rate
  keyboard-repeat = {
    rate = "50";
    delay = "300";
  };
  # Define Tags Operation
  tags = {
    count = 7;
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
    border-color-focused = "0xd8dee9";
    border-color-unfocused = "0x3b4252";
    border-width = "4";
  };
}
