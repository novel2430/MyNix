{pkgs, opt-config, ...}:
{
  systemd.user.services = {
    nextlab-ss = {
      enable = true;
      description = "Nextlab V2ray Client";
      after = ["network.target"];
      wantedBy = ["default.target"];
      serviceConfig = {
        Type = "simple";
        Restart = "on-abort";
        ExecStart = "${pkgs.v2ray}/bin/v2ray run -config /home/${opt-config.username}/v2ray/config.json";
      };
    };
  };
}
