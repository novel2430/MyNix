{ modify-pkgs, ... }:
{
  programs.chromium = {
    enable = true;
    package = modify-pkgs.brave;
    extensions = [
      { id = "padekgcemlokbadohgkifijomclgjgif"; } # Proxy SwitchyOmega
      { id = "dhdgffkkebhmkfjojejmpbldmpobfkfo"; } # TamperMonkey
    ];
    commandLineArgs = [
    ];
  };
}
