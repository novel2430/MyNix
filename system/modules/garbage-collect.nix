{
  # Garbage Collection
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 15d";
  };
  nix.settings.auto-optimise-store = true;

}
