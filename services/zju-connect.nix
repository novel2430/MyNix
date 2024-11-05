{pkgs, opt-config, ...}:
{
  systemd.user.services = {
    zjuconnect = {
      enable = true;
      description = "ZJU Rvpn Client";
      after = ["network.target"];
      wantedBy = ["default.target"];
      serviceConfig = {
        Type = "simple";
        Restart = "on-abort";
        ExecStart = "${pkgs.nur.repos.novel2430.zju-connect}/bin/zju-connect -config ${opt-config.zju-rvpn-config}";
      };
    };
  };
}
