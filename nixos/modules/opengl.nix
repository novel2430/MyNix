{ pkgs, lib, opt-config, ...}:
{
  # OpenGL
  hardware.opengl = lib.mkMerge [
    ({
      package = pkgs.mesa.drivers;
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    })
    (lib.mkIf (opt-config.gpu-type == "amd") {
      extraPackages = with pkgs; [
        rocmPackages.clr.icd
        amdvlk
      ];
      extraPackages32 = with pkgs; [
        driversi686Linux.amdvlk
      ];
    })
  ];
}
