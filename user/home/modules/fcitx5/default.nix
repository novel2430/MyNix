{ config, pkgs, ... }:

{
  i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = 
    with pkgs; [
        fcitx5-chewing
        fcitx5-configtool
        fcitx5-chinese-addons
        # unstable.fcitx5-mcbopomofo
        fcitx5-nord
    ];
  };
}
