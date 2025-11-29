{pkgs, lib, opt-config, ...}:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "github.com" = lib.mkMerge [
        ({
          hostname = "ssh.github.com";
          port = 443;
          user = "git";
          identityFile = "~/.ssh/github";
        })
        (lib.mkIf (opt-config.use-proxy == true) {
          proxyCommand = "socat - PROXY:${opt-config.http-proxy-host}:%h:%p,proxyport=${opt-config.http-proxy-port}";
        })
      ];
      "nextlab" = lib.mkMerge [
        ({
          hostname = "10.214.243.10";
          port = 110;
          user = "nextlab";
        })
        (lib.mkIf (opt-config.use-zju-rvpn == true) {
          proxyCommand = "socat - PROXY:127.0.0.1:%h:%p,proxyport=${opt-config.zju-rvpn-port}";
        })
      ];
    };
    # extraConfig = ''
    # '';
  };
}
