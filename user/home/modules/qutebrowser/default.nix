{custom-pkgs,pkgs, ...}:
{
  home.file.".config/qutebrowser/config.py".source = ./config.py;
  home.file.".config/qutebrowser/quickmarks".source = ./quickmarks;

  home.packages = [
    (pkgs.qutebrowser.override {
      enableWideVine = true; 
    })
  ];
}
