{ pkgs, lib, opt-config, ...}:
{
  programs.git = {
    enable = true;
    userName = "${opt-config.gitname}";
    userEmail = "${opt-config.gitmail}";
    extraConfig = lib.mkMerge [
      ({init.defaultBranch = "${opt-config.gitbranch}";})
      (lib.mkIf (opt-config.use-proxy == true){
        http.proxy = "${opt-config.http-proxy}";
        https.proxy = "${opt-config.https-proxy}";
      })
    ];
  };
}
