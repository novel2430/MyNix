{ pkgs, opt-config,... }:
{
  home.file.".config/greenclip.toml" = {
    text = ''
      [greenclip]
        history_file = "/home/${opt-config.username}/.cache/greenclip.history"
        max_history_length = 100
        max_selection_size_bytes = 0
        trim_space_from_selection = true
        use_primary_selection_as_input = false
        blacklisted_applications = []
        enable_image_support = true
        image_cache_directory = "/tmp/greenclip"
        static_history = [ "Hello! Greenclip!" ]
    '';
  };
  home.packages = [
    pkgs.haskellPackages.greenclip
  ];
}
