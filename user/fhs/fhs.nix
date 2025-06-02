{pkgs, ...}:
let
  libs = with pkgs; [
    # Basic
    bash
    zsh
    autoconf
    binutils
    curl
    git
    gnumake
    stdenv.cc
    unzip
    util-linux
    wget
    vim
    neovim
    python312
    pkg-config
  ];
  base = pkgs.appimageTools.defaultFhsEnvArgs;
  new-home-dir = "$HOME/MyFHS";
  startScript = pkgs.writeShellScript "start" ''
    mkdir -p $HOME
    cd $HOME
    zsh
  '';
in
with pkgs; buildFHSEnv {
  name = "MyFHS";
  targetPkgs = pkgs:
    (base.targetPkgs pkgs)
    ++
    libs;
  multiPkgs = pkgs: [ zlib ];
  profile = ''
    # other
    export HOME="${new-home-dir}"
    export SHELL=zsh
  '';
  runScript = startScript;
  extraOutputsToInstall = ["dev"];
}
