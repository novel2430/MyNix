{pkgs, opt-config, ...}:
{
  systemd.user.services = {
    mihomo = {
      enable = true;
      description = "Mihomo (Clash Meta), Good Way to Love GFW";
      after = ["network.target"];
      wantedBy = ["default.target"];
      serviceConfig = {
        Type = "simple";
        Restart = "on-abort";
        ExecStart = "${pkgs.unstable.mihomo}/bin/mihomo -d ${opt-config.clash-dir}";
      };
    };
  };
}
