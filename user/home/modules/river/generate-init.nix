{pkgs, lib, ...}:
with lib;
let
  config = import ./init.nix { inherit pkgs; };

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
  formatViewRulesSsd = binding:(
    if binding ? title then
      "riverctl rule-add -app-id '${binding.app-id}' -title '${binding.title}' ssd"
    else
      "riverctl rule-add -app-id '${binding.app-id}' ssd"
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
  formatKeybindingPointer = binding: (
      "riverctl map-pointer normal ${binding.keys} ${binding.action}"
  );
in
with config; {
  home.file.".config/river/init" = {
    text = ''
      #!/bin/sh

      # River configuration
      # Basic
      ${concatStringsSep "\n" (builtins.map formatKeybindingBasic keybindings.basic)}
      # Apps
      ${concatStringsSep "\n" (builtins.map formatKeybindingApps keybindings.apps)}
      # Pointer
      ${concatStringsSep "\n" (builtins.map formatKeybindingPointer keybindings.pointer)}

      # Background and Border configuration
      ${concatStringsSep "\n" (mapAttrsToList formatBackgroundBorderSettings background-border-settings)}

      # View Rules
      # Floating
      ${concatStringsSep "\n" (builtins.map formatViewRulesFloat view-rules.floating)}
      # Csd
      ${concatStringsSep "\n" (builtins.map formatViewRulesCsd view-rules.csd)}
      # Ssd
      ${concatStringsSep "\n" (builtins.map formatViewRulesSsd view-rules.ssd)}

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
