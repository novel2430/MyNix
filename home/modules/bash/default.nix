{pkgs, lib, opt-config,  ... }:
{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    # TODO 在这里添加你的自定义 bashrc 内容
    bashrcExtra = lib.mkMerge [
      (lib.mkIf (opt-config.use-proxy == true) ''
        export http_proxy="${opt-config.http-proxy}"
        export https_proxy="${opt-config.https-proxy}"
      '')
      # Other Stuff
      (''
      '')
    ];
    #shellAliases = {
    #};
  };

}
