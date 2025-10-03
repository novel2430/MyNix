{ pkgs, opt-config, ... }:
{
  home.file.".config/alacritty/alacritty.toml" = {
    text = ''
      [window]
      decorations = "Full"
      #startup_mode = "Windowed" | "Maximized" | "Fullscreen" | "SimpleFullscreen"
      #startup_mode = "Maximized"
      startup_mode = "Windowed"
      opacity = 0.8

      [scrolling]
      history = 30000
      multiplier = 3

      [font]
      normal = { family = "Hack Nerd Font", style = "Regular" }
      size = ${opt-config.alacritty-font-size}

      [colors.primary]
      background = "#20281f"
      foreground = "#cdcecf"

      [colors.normal]
      black = "#3b4252"
      red = "#bf616a"
      green = "#a3be8c"
      yellow = "#ebcb8b"
      blue = "#81a1c1"
      magenta = "#b48ead"
      cyan = "#88c0d0"
      white = "#e5e9f0"

      [colors.bright]
      black = "#465780"
      red = "#d06f79"
      green = "#b1d196"
      yellow = "#f0d399"
      blue = "#8cafd2"
      magenta = "#c895bf"
      cyan = "#93ccdc"
      white = "#e7ecf4"
    '';
  };
  home.packages = [
    pkgs.alacritty
  ];
}
