{opt-config, lib, ...}:
with lib;
let
  wofi-config = import ./config.nix {inherit opt-config;};
  formatConfig = key: value: (
    "${key}=${value}"
  );
  formatStyle = section: 
  let
    formatContent = key: value: (
      "  ${key}: ${value};"
    );
  in
  (
    ''
      ${section.title} {
      ${concatStringsSep "\n" (mapAttrsToList formatContent section.content)}
      }
    '' 
  );
in
with wofi-config;
{
  home.file.".config/wofi/config" = {
    text = ''
      ${concatStringsSep "\n" (mapAttrsToList formatConfig config)}
    '';
  };

  home.file.".config/wofi/style.css" = {
    text = ''
      ${concatStringsSep "\n" (builtins.map formatStyle style)}
    '';
  };
  # home.file.".config/wofi/style.css".source = ./style.css;

}
