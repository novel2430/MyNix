{pkgs, custom-pkgs, ...}: 
{
  services.upower = {
    enable = true;
    ignoreLid = true;
  };
}
