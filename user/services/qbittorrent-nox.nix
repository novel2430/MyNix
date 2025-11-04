{pkgs, opt-config, ...}:
{
  systemd.user.services = {
    qbittorrent-nox = {
      enable = true;
      description = "QBittorent Daemon";
      after = ["network.target"];
      wantedBy = ["default.target"];
      serviceConfig = {
        Type = "simple";
        Restart = "on-abort";
        ExecStart = "${pkgs.qbittorrent-nox}/bin/qbittorrent-nox";
      };
    };
  };
}
