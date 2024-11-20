{ config, ... }:
{

  security.polkit.enable = true;

  boot.kernelModules = [ "snd-usb-audio" ];
}
