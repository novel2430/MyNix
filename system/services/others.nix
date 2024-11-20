{opt-config, ...}:
{
  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;
  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  # Dbus
  services.dbus.enable = true;
  # rtkit
  security.rtkit.enable = true;
  # usbmuxd
  services.usbmuxd.enable = true;
  # Auto cpu freq
  services.auto-cpufreq.enable = opt-config.autocpu;
  # Flatpak
  # services.flatpak.enable = true;

}
