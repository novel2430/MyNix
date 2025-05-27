{pkgs, lib, doomemacs, config, opt-config, ...}: 
let
doom = pkgs.writeShellScriptBin "doom" ''
  DOOMLOCALDIR=$HOME/.local/share/doomemacs DOOMDIR=$HOME/.doom.d ${doomemacs}/bin/doom "$@"
'';
emacs = pkgs.writeShellScriptBin "emacs" ''
  DOOMLOCALDIR=$HOME/.local/share/doomemacs DOOMDIR=$HOME/.doom.d ${pkgs.emacs30-pgtk}/bin/emacs "$@"
'';
emacsclient = pkgs.writeShellScriptBin "emacsclient" ''
  DOOMLOCALDIR=$HOME/.local/share/doomemacs DOOMDIR=$HOME/.doom.d ${pkgs.emacs30-pgtk}/bin/emacsclient "$@"
'';
emacsc-run = pkgs.writeShellScriptBin "emacs-run" ''
  # 启动 Emacs Daemon 如果尚未启动
  if ! emacsclient -e "(daemonp)" 2>/dev/null | grep -q t; then
    echo "Starting Emacs daemon..."
    emacs --daemon
  fi
  # 使用 emacsclient 打开 GUI（--create-frame）支持 Wayland/X11
  emacsclient -c
'';
  cacheDir = "/home/${opt-config.username}/.local/share/doomemacs/etc/lsp/lua-language-server";
  vtermDir = "/home/${opt-config.username}/.local/share/doomemacs/packages";
  jdtlsDir = "/home/${opt-config.username}/.local/share/doomemacs/packages/jdtls";
in
{
  home.packages = with pkgs; [
    emacs
    emacsclient
    emacsc-run
    doom
    ripgrep
    findutils
    fd
    emacsPackages.vterm
    #pkgs.nerd-fonts.symbols-only
    ## For LSP
    pandoc # Markdown
    shellcheck # Shell
    lua-language-server # Lua
    pyright # Python
    clang-tools # C family
    jdt-language-server # Java
    nil # Nix
    nodePackages.bash-language-server # Bash
    rust-analyzer # Rust
    vue-language-server # Vue
  ];

  home.file.".emacs.d".source = doomemacs;
  home.file.".doom.d" = {
    recursive = true;
    source = ./.doom.d;
  };

  home.activation.linkLuaLS = config.lib.dag.entryAfter ["writeBoundary"] ''
    mkdir -p "${cacheDir}"

    rm -rf "${cacheDir}/bin"
    ln -sf ${pkgs.lua-language-server}/share/lua-language-server/bin "${cacheDir}/bin"

    rm -rf "${cacheDir}/changelog.md"
    ln -sf ${pkgs.lua-language-server}/share/lua-language-server/changelog.md "${cacheDir}/changelog.md"
    
    rm -rf "${cacheDir}/debugger.lua"
    ln -sf ${pkgs.lua-language-server}/share/lua-language-server/debugger.lua "${cacheDir}/debugger.lua"

    rm -rf "${cacheDir}/locale"
    ln -sf ${pkgs.lua-language-server}/share/lua-language-server/locale "${cacheDir}/locale"

    rm -rf "${cacheDir}/main.lua"
    ln -sf ${pkgs.lua-language-server}/share/lua-language-server/main.lua "${cacheDir}/main.lua"

    rm -rf "${cacheDir}/meta"
    ln -sf ${pkgs.lua-language-server}/share/lua-language-server/meta "${cacheDir}/meta"

    rm -rf "${cacheDir}/script"
    ln -sf ${pkgs.lua-language-server}/share/lua-language-server/script "${cacheDir}/script"
  '';
  home.activation.linkVterm = config.lib.dag.entryAfter ["writeBoundary"] ''
    mkdir -p "${vtermDir}"
    rm -rf "${vtermDir}/elpa"
    ln -sf ${pkgs.emacsPackages.vterm}/share/emacs/site-lisp/elpa  "${vtermDir}/elpa"
  '';
  home.activation.linkJdtls = config.lib.dag.entryAfter ["writeBoundary"] ''
    mkdir -p "${jdtlsDir}"
    mkdir -p "${jdtlsDir}/config_linux"

    rm -rf "${jdtlsDir}/config_linux/config.ini"
    ln -sf ${pkgs.jdt-language-server}/share/java/jdtls/config_linux/config.ini  "${jdtlsDir}/config_linux/config.ini"

    rm -rf "${jdtlsDir}/features"
    ln -sf ${pkgs.jdt-language-server}/share/java/jdtls/features  "${jdtlsDir}/features"

    rm -rf "${jdtlsDir}/plugins"
    ln -sf ${pkgs.jdt-language-server}/share/java/jdtls/plugins  "${jdtlsDir}/plugins"
  '';

}
