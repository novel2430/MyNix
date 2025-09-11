{pkgs, lib, opt-config,  ... }:
let
  my-profile = lib.mkMerge [
    (lib.mkIf (opt-config.force-gl-gtk == true) ''
      export GSK_RENDERER=opengl
    '')
    (lib.mkIf (opt-config.use-proxy == true) ''
      export http_proxy="${opt-config.http-proxy}"
      export https_proxy="${opt-config.https-proxy}"
    '')
    # JAVA
    (''
      export JAVA_17_HOME="${pkgs.jdk17}/bin"
      export JAVA_21_HOME="${pkgs.jdk21}/bin"
      export EMACS_JAVA_21_HOME="${pkgs.openjdk21}/lib/openjdk"
      export EMACS_JAVA_21_PATH="${pkgs.openjdk21}/lib/openjdk/bin/java"
    '')
    (''
      export FZF_COMPLETION_TRIGGER='\'
    '')
    (''
      export EDITOR="nvim"
      export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=245"
      export AWESOMEWM_BAR_CLIENT_TITLE_MAX_LEN="${opt-config.awesomewm-bar-client-title-max-len}"
      export XDG_CACHE_HOME="/home/${opt-config.username}/.cache"
      export HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1
      export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="fg=yellow"
      export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND="fg=red"
      export XDG_DATA_DIRS=$XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share
    '')
  ];
in
{
  programs.bash.profileExtra = my-profile;
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    autocd = true;
    syntaxHighlighting.enable = false;
    shellAliases = {
      showimage = "sudo nix-env --profile /nix/var/nix/profiles/system --list-generations";
      delimage = "sudo nix-env --profile /nix/var/nix/profiles/system --delete-generations";
      startx = "rm ~/.Xauthority; startx";
      ls = "${pkgs.eza}/bin/eza --icons auto";
      neofetch = "${pkgs.fastfetch}/bin/fastfetch";
      gitall = "git add . && git commit -m 'update' && git push";
      v = "nvim";
      fhs = "nix develop ~/MyNix#fhs";
      cat = "${pkgs.bat}/bin/bat -p";
      yz = "${pkgs.yazi}/bin/yazi";
    };
    initContent = lib.mkMerge [
      # Other Stuff
      (''
        [ -f "$HOME/.private_env" ] && source "$HOME/.private_env"

        setopt hist_verify
        setopt NO_BEEP
        setopt HIST_IGNORE_ALL_DUPS
        setopt no_nomatch
        
        bindkey '^?' backward-delete-char
        bindkey '^[[3~' delete-char
        bindkey '^L' clear-screen


        zstyle ":completion:*" menu select
        zstyle ":completion:*" special-dirs true
        zstyle ":completion:*" list-colors ''${(s.:.)LS_COLORS} 

        autoload -Uz vcs_info

        preexec() {
          print -Pn "\e]0;$1\a"
        }
        precmd() { 
          vcs_info 
          print -Pn "\e]0;%n@%m:%~\a"
          
        }
        setopt prompt_subst
        zstyle ':vcs_info:*' enable git
        zstyle ':vcs_info:git:*' check-for-changes true
        zstyle ':vcs_info:git:*' stagedstr '%F{green}+%f'
        zstyle ':vcs_info:git:*' unstagedstr '%F{yellow}!%f'
        zstyle ':vcs_info:git:*' formats '(%F{red}%b%f)%u%c '

        export PROMPT='%B%F{blue}[%n:%F{green}%~%F{blue}]$%f%b ''${vcs_info_msg_0_}'
      '')
      # FZF Stuff
      (''
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
      # zsh-history-substring-search
      (''
        source ${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search/zsh-history-substring-search.zsh
        bindkey '^P' history-substring-search-up
        bindkey '^N' history-substring-search-down
        bindkey '^[[1;5A' history-substring-search-up
        bindkey '^[[1;5B' history-substring-search-down
      '')
      # zsh-syntax-highlighting -- Must Last
      (''
        source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
      '')
      (lib.mkIf (opt-config.use-proxy == true) ''
        alias nixos-rebuild="sudo http_proxy=${opt-config.http-proxy} https_proxy=${opt-config.https-proxy} nixos-rebuild"
      '')
    ];
    profileExtra = my-profile;
  };
}
