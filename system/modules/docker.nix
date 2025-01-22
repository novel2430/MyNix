{lib, opt-config, ...}:
{
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = false;
      setSocketVariable = true;
    };
    daemon.settings = lib.mkMerge [
      (lib.mkIf (opt-config.use-proxy == true) {
        proxies = {
          http-proxy = "${opt-config.http-proxy}";
          https-proxy = "${opt-config.https-proxy}";
        };
      }) 
    ];
  };
}
