{custom-pkgs, ...}:
{
  home.file.".config/qutebrowser/config.py".source = ./config.py
  home.file.".config/qutebrowser/quickmarks".source = ./quickmarks
  home.file.".config/qutebrowser/bookmarks/urls".source = ./bookmarks/urls

  home.packages = [
    custom-pkgs.qutebrowser
  ];
}
