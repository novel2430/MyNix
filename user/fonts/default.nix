{pkgs, custom-pkgs, ...}: 
{

  fonts = {
    packages = with pkgs; [
      noto-fonts
      nerd-fonts.hack
      nerd-fonts.jetbrains-mono
      nerd-fonts.roboto-mono
      nerd-fonts.ubuntu
      nerd-fonts.dejavu-sans-mono
      nur.repos.novel2430.latex-chinese-fonts
    ];
    fontDir.enable = true;
    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = ["DejaVu Serif" "Hack Nerd Font" "WenQuanYi Zen Hei" "Noto Sans"];
        sansSerif = ["DejaVu Sans" "Hack Nerd Font" "WenQuanYi Zen Hei" "Noto Sans"];
        monospace = ["DejaVu Sans Mono" "Hack Nerd Font" "WenQuanYi Zen Hei" "Noto Sans"];
        emoji = ["DejaVu Serif" "Hack Nerd Font"];
      };
    };
  };
}
