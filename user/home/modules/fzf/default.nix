{pkgs, ...}:
{
  home.packages = with pkgs;[
    bat
    fd
  ];

  programs.fzf = {
    enable = true;
    defaultCommand = "fd --type f";
    defaultOptions = [
      "--height 40%"
      "--border"
      "--layout reverse"
      "--preview 'bat --color=always {}'"
      "--bind 'ctrl-/:change-preview-window(50%|hidden|)'"
    ];
    enableZshIntegration = true;
    colors = {
      "bg+" = "#6e7275";
      border = "#eceff4";
      gutter = "-1";
    };
  };
}
