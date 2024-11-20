{
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    displayManager = {
      startx.enable = true;
    };
    # Configure keymap in X11
    xkb.layout = "us";
  };
}
