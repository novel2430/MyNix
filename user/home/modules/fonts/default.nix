{pkgs, custom-pkgs, ...}: 
{
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Hack" "JetBrainsMono" "RobotoMono" "Ubuntu" "DejaVuSansMono" ]; })
    nur.repos.novel2430.latex-chinese-fonts
  ];
}
