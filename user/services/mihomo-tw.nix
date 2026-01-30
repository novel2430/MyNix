{pkgs, opt-config, ...}:
{
  systemd.user.services = {
    mihomo-tw = {
      enable = true;
      description = "Mihomo (Clash Meta), Good Way to Love GFW, TW only";
      after = ["network.target"];
      wantedBy = ["default.target"];
      serviceConfig = {
        Type = "simple";
        Restart = "on-abort";
        ExecStart = "${pkgs.unstable.mihomo}/bin/mihomo -d /home/${opt-config.username}/clash-tw";
      };
    };
  };
}
