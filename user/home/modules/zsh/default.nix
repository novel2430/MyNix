{pkgs, lib, opt-config,  ... }:
{
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    oh-my-zsh.enable = true;
    oh-my-zsh.plugins = [ "git" ];
    oh-my-zsh.theme = "robbyrussell";
    syntaxHighlighting.enable = true;
    shellAliases = {
      showimage = "sudo nix-env --profile /nix/var/nix/profiles/system --list-generations";
      delimage = "sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations";
      startx = "rm ~/.Xauthority; startx";
      ls = "${pkgs.eza}/bin/eza --icons auto";
      cat = "${pkgs.bat}/bin/bat";
      neofetch = "${pkgs.fastfetch}/bin/fastfetch";
      gitall = "git add . && git commit -m 'update' && git push";
    };
    initExtra = lib.mkMerge [
      (lib.mkIf (opt-config.use-proxy == true) ''
        export http_proxy="${opt-config.http-proxy}"
        export https_proxy="${opt-config.https-proxy}"
        alias nixos-rebuild="sudo http_proxy=${opt-config.http-proxy} https_proxy=${opt-config.https-proxy} nixos-rebuild"
      '')
      # Other Stuff
      (''
        export EDITOR="nvim"
        export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=245"
        export AWESOMEWM_BAR_CLIENT_TITLE_MAX_LEN="${opt-config.awesomewm-bar-client-title-max-len}"
      '')
      # FZF Stuff
      (''
        export FZF_COMPLETION_TRIGGER='\'
        # Use fd (https://github.com/sharkdp/fd) for listing path candidates.
        # - The first argument to the function ($1) is the base path to start traversal
        # - See the source code (completion.{bash,zsh}) for the details.
        _fzf_compgen_path() {
          fd --follow --exclude ".git" . "$1"
        }

        # Use fd to generate the list for directory completion
        _fzf_compgen_dir() {
          fd --type d --follow --exclude ".git" . "$1"
        }
      '')
      # JAVA
      (
      ''
        export JAVA_17_HOME="${pkgs.jdk17}/bin"
        export JAVA_21_HOME="${pkgs.jdk21}/bin"
      ''
      )
    ];
  };
}
