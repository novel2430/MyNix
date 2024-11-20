{pkgs, ...}:
{
  systemd.services = {
    no-keyboard = {
      enable = true;
      description = "No Keyboard";
      # after = ["network.target"];
      wantedBy = ["multi-user.target"];
      serviceConfig = {
        Type = "simple";
        Restart = "on-abort";
        ExecStart = "${pkgs.evtest}/bin/evtest --grab /dev/input/event0";
      };
    };
  };
}
