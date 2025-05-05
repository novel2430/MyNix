{pkgs, opt-config, ...}:
{
  home.packages = [
    (import ./autostart.nix {
      inherit pkgs;
      inherit opt-config;
    })
    (import ./cpu.nix {
      inherit pkgs;
    })
    (import ./temp.nix {
      inherit pkgs;
    })
  ];

}
