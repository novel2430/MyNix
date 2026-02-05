{pkgs, custom-pkgs, opt-config, ...}: 
let
in
{
  home.packages = with pkgs; [
    custom-pkgs.emacs29-pgtk-xwidget
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
    kotlin-language-server # Kotlin
  ];

}
