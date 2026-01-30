{lib, opt-config, ... }:
{
  imports = 
    [
      ./nextlab-ss.nix
      ./media-idle-guard.nix
    ]
    ++
    lib.optionals (opt-config.use-clash == true) [
      ./mihomo.nix
    ]
    ++
    lib.optionals (opt-config.use-zju-rvpn == true) [
      ./zju-connect.nix
    ]
    ++
    lib.optionals (opt-config.no-keyboard == true) [
      ./disable-keyboard.nix
    ]
    ++
    lib.optionals (opt-config.use-qb == true) [
      ./qbittorrent-nox.nix
    ]
    ++
    lib.optionals (opt-config.use-clash == true) [
      ./mihomo-tw.nix
    ]
  ;

}

