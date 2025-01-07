{pkgs, opt-config, ...}:
{
  systemd.user.services = {
    nextlab-ss = {
      enable = true;
      description = "Nextlab Shadowsocks Client";
      after = ["network.target"];
      wantedBy = ["default.target"];
      serviceConfig = {
        Type = "simple";
        Restart = "on-abort";
        ExecStart = "${pkgs.shadowsocks-rust}/bin/sslocal -c /home/${opt-config.username}/shadowsocks/config.json";
      };
    };
  };
}
