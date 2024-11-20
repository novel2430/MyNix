{pkgs, ...}:
{
  home.file.".config/tint2/tint2rc".source = ./tint2rc;
  
  home.packages = [
    pkgs.tint2
  ];
}
