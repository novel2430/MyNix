{pkgs, custom-pkgs, ...}: 
{
  home.packages = with pkgs; [
    noto-fonts
    (nerdfonts.override { fonts = [ "Hack" "JetBrainsMono" "RobotoMono" "Ubuntu" "DejaVuSansMono" ]; })
    nur.repos.novel2430.latex-chinese-fonts
  ];
}
