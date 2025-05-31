{pkgs, custom-pkgs, ...}: 
{
  home.packages = with pkgs; [
    noto-fonts
    nerd-fonts.hack
    nerd-fonts.jetbrains-mono
    nerd-fonts.roboto-mono
    nerd-fonts.ubuntu
    nerd-fonts.dejavu-sans-mono
    nur.repos.novel2430.latex-chinese-fonts
  ];
}
