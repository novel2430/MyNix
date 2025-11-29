{ pkgs, lib, opt-config, ...}:
{
  programs.git = {
    enable = true;
    settings = lib.mkMerge [
      ({user.name = "${opt-config.gitname}";})
      ({user.email = "${opt-config.gitmail}";})
      ({init.defaultBranch = "${opt-config.gitbranch}";})
      (lib.mkIf (opt-config.use-proxy == true){
        http.proxy = "${opt-config.http-proxy}";
        https.proxy = "${opt-config.https-proxy}";
      })
    ];
  };
}
