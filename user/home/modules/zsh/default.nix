{pkgs, lib, opt-config,  ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    autocd = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      showimage = "sudo nix-env --profile /nix/var/nix/profiles/system --list-generations";
      delimage = "sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations";
      startx = "rm ~/.Xauthority; startx";
      ls = "${pkgs.eza}/bin/eza --icons auto";
      cat = "${pkgs.bat}/bin/bat";
      neofetch = "${pkgs.fastfetch}/bin/fastfetch";
      gitall = "git add . && git commit -m 'update' && git push";
      v = "nvim";
    };
    initExtra = lib.mkMerge [
      # Other Stuff
      (''
        zstyle ":completion:*" menu select
        zstyle ":completion:*" special-dirs true
        zstyle ":completion:*" list-colors ''${(s.:.)LS_COLORS} 

        autoload -Uz vcs_info
        precmd() { vcs_info }
        setopt prompt_subst
        # 启用 git 支持
        zstyle ':vcs_info:*' enable git
        # 显示修改状态（如 + 有 staged 改动，! 有 unstaged）
        zstyle ':vcs_info:git:*' check-for-changes true
        zstyle ':vcs_info:git:*' stagedstr '%F{green}+%f'
        zstyle ':vcs_info:git:*' unstagedstr '%F{yellow}!%f'
        zstyle ':vcs_info:git:*' formats '(%F{red}%b%f)%u%c '

        PROMPT='%B%F{green}[%n:%F{blue}%~%F{green}]$%f%b ''${vcs_info_msg_0_}'

        export EDITOR="nvim"
        export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=245"
        export AWESOMEWM_BAR_CLIENT_TITLE_MAX_LEN="${opt-config.awesomewm-bar-client-title-max-len}"
        export XDG_CACHE_HOME="/home/${opt-config.username}/.cache"
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
      (lib.mkIf (opt-config.use-proxy == true) ''
        export http_proxy="${opt-config.http-proxy}"
        export https_proxy="${opt-config.https-proxy}"
        alias nixos-rebuild="sudo http_proxy=${opt-config.http-proxy} https_proxy=${opt-config.https-proxy} nixos-rebuild"
      '')
    ];
  };
}
