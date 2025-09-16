{ pkgs, ...}:
{
  # OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver    # HD4000 建议也装上，VA-API/视频输出更稳
      vaapiIntel
      libvdpau-va-gl
    ];
  };

}
