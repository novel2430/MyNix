{pkgs, opt-config, ...}:
{
  home.file.".config/wezterm/wezterm.lua" = {
    source = ./wezterm.lua;
  };
  home.file.".config/wezterm/config" = {
    recursive = true;
    source = ./config;
  };
  home.file.".config/wezterm/config/fonts.lua" = {
    text = ''
      local M = {}
      M.font = {
        {family="Hack Nerd Font", weight='Regular'},

        {family="Adobe Heiti Std", weight="Regular"},
        -- /home/wez/.fonts/OperatorMonoSSmLig-Medium.otf, FontDirs
        {family="Operator Mono SSm Lig", weight="DemiLight"},

        -- /home/wez/.fonts/MaterialDesignIconsDesktop.ttf, FontDirs
        "Material Design Icons Desktop",

        -- /usr/share/fonts/jetbrains-mono-fonts/JetBrainsMono-Regular.ttf, FontConfig
        "JetBrains Mono",

        -- /usr/share/fonts/google-noto-emoji/NotoColorEmoji.ttf, FontConfig
        -- Assumed to have Emoji Presentation
        -- Pixel sizes: [128]
        "Noto Color Emoji",
      }
      M.font_size = 14
      return M
    '';
  };

  home.packages = [
    pkgs.wezterm
  ];
}
