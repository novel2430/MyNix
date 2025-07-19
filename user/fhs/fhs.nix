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
    gcc
    python310Full
    python312Full
    nodejs_22
    # Others - MSST
    # portaudio
    # pango
    # cairo
    # harfbuzz
    # fontconfig
    # freetype
    # gdk-pixbuf
    # atk
    # gobject-introspection
    # xorg.libX11
    # xorg.xorgproto
    # xorg.libXext
    # xorg.libXi
    # xorg.libXrandr
    # xorg.libXinerama
    # xorg.libXcursor
    # xorg.libXcomposite
    # xorg.libXdamage
    # xorg.libXrender
    # xorg.libXtst
    # libepoxy
    # wayland
    # gtk3
    # gtkmm3
    # gtk2
    # gtkmm2
    # glib
    # glibc
    # Others - MIDI -> AUDIO
    # fluidsynth
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
    export LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath libs}:$LD_LIBRARY_PATH"
    export SHELL=zsh
  '';
  runScript = startScript;
  extraOutputsToInstall = ["dev"];
}
