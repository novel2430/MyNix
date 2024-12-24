{pkg-settings}:
{
  Default = with pkg-settings; rec {
    name = "Default";
    config = (import ../hosts/${name}/options.nix { pkgs = stable-pkgs; unstable-pkgs = unstable-pkgs; }).opt-config;
  };
  ThinkPad-X230 = with pkg-settings; rec {
    name = "ThinkPad-X230";
    config = (import ../hosts/${name}/options.nix { pkgs = stable-pkgs; unstable-pkgs = unstable-pkgs; }).opt-config;
  };
  MAXSUN-b450m = with pkg-settings; rec {
    name = "MAXSUN-b450m";
    config = (import ../hosts/${name}/options.nix { pkgs = stable-pkgs; unstable-pkgs = unstable-pkgs; }).opt-config;
  };

  ASUSTek = with pkg-settings; rec {
    name = "ASUSTek";
    config = (import ../hosts/${name}/options.nix { pkgs = stable-pkgs; unstable-pkgs = unstable-pkgs; }).opt-config;
  };
}
