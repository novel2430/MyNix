{ pkgs, lib, ... }:
with lib;
let
  # Define paths to custom and standard applications
  apps = {
    foot = "${pkgs.foot}/bin/foot";
    brightnessctl = "${pkgs.brightnessctl}/bin/brightnessctl";
    wofi = "${pkgs.wofi}/bin/wofi";
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


  # Helper function to generate commands
  pow = x: y:
    if y == 0 then 1 else x * pow x (y - 1);
  formatKeybindingBasic = binding: 
    concatStringsSep "\n" (builtins.map (mode: "riverctl map ${mode} ${binding.keys} ${binding.action}") binding.modes);
  formatKeybindingApps = binding: 
    concatStringsSep "\n" (builtins.map (mode: "riverctl map ${mode} ${binding.keys} spawn '${binding.action}'") binding.modes);
  formatBackgroundBorderSettings = k: v: 
    "riverctl ${k} ${v}";
  formatViewRulesFloat = binding:
    (
      if binding ? title then
        "riverctl rule-add -app-id '${binding.app-id}' -title '${binding.title}' float"
      else
        "riverctl rule-add -app-id '${binding.app-id}' float"
    );
  formatViewRulesCsd = binding:(
    if binding ? title then
      "riverctl rule-add -app-id '${binding.app-id}' -title '${binding.title}' csd"
    else
      "riverctl rule-add -app-id '${binding.app-id}' csd"
  );
  formatGaps = binding:(
    if binding.smart-gap == true then
      "rivercarro -outer-gaps ${binding.outer} -inner-gaps ${binding.inner} &\n"
    else
      "rivercarro -no-smart-gaps -outer-gaps ${binding.outer} -inner-gaps ${binding.inner} &\n"
  );
  formatKeyboardRepeat = binding:(
    "riverctl set-repeat ${binding.rate} ${binding.delay}"
  );
  formatTags = binding: count: (
    let
      generate = count: 
        let
          str-count = builtins.toString count;
          tags = builtins.toString (pow 2 (count - 1));
        in
          if count > 0 then
            [''
              riverctl map normal ${binding.keybindings.set-focused-tags} ${str-count} set-focused-tags ${tags}
              riverctl map normal ${binding.keybindings.set-view-tags} ${str-count} set-view-tags ${tags}
              riverctl map normal ${binding.keybindings.toggle-focused-tags} ${str-count} toggle-focused-tags ${tags}
            '']
            ++ generate (count - 1) 
          else [];
    in
      concatStringsSep "\n" (generate count)
  );
  formatShowAllTags = binding: (
    ''
      all_tags=$(((1 << 32) - 1))
      riverctl map normal ${binding.keybindings.all-tags} set-focused-tags $all_tags
    ''
  );

in {
  home.file.".config/river/init" = {
    text = ''
      #!/bin/sh

      # River configuration
      # Basic
      ${concatStringsSep "\n" (builtins.map formatKeybindingBasic keybindings.basic)}
      # Apps
      ${concatStringsSep "\n" (builtins.map formatKeybindingApps keybindings.apps)}

      # Background and Border configuration
      ${concatStringsSep "\n" (mapAttrsToList formatBackgroundBorderSettings background-border-settings)}

      # View Rules
      # Floating
      ${concatStringsSep "\n" (builtins.map formatViewRulesFloat view-rules.floating)}
      # Csd
      ${concatStringsSep "\n" (builtins.map formatViewRulesCsd view-rules.csd)}

      # Tags Operation
      ${formatTags tags tags.count}
      ${formatShowAllTags tags}

      # Set keyboard repeat rate
      ${formatKeyboardRepeat keyboard-repeat}

      # Default layout and autostart
      riverctl default-layout rivercarro
      # Gaps
      ${formatGaps gaps}

      if [ $# -eq 0 ]; then
        my-river-autostart
      fi
    '';
    executable = true;
  };
}
