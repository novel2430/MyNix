{pkgs, custom-pkgs, ...}: 
{
  home.packages = with pkgs; [
    (nerdfonts.override { fonts = [ "Hack" "JetBrainsMono" "RobotoMono" "Ubuntu" "DejaVuSansMono" ]; })
    custom-pkgs.latex-chinese-fonts
  ];
}
