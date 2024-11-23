{ pkgs, ... }:
{
  programs.chromium = {
    enable = true;
    package = pkgs.brave;
    extensions = [
      { id = "padekgcemlokbadohgkifijomclgjgif"; } # Proxy SwitchyOmega
      { id = "dhdgffkkebhmkfjojejmpbldmpobfkfo"; } # TamperMonkey
    ];
    commandLineArgs = [
    ];
  };
}
