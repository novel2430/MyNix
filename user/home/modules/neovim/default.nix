{ pkgs, custom-pkgs, opt-config, ... }:
{
  programs.neovim = 
  let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
    buildJdtConfig = import ./lsp-jdtls.nix {
      java = pkgs.jdk; # JDK21
      jdt = pkgs.jdt-language-server;
      lombok = pkgs.lombok;
      opt-config = opt-config;
    };
    buildVueConfig = import ./lsp-vue.nix { inherit pkgs; };
  in
  {
    enable = true;
    # Custom Plugin Package add to nixpkgs
     
    # Language Server Package
    extraPackages = with pkgs; [
      lua-language-server # Lua
      pyright # Python
      clang-tools # C family
      jdt-language-server # Java
      nil # Nix
      nodePackages.bash-language-server # Bash
      rust-analyzer # Rust
      vue-language-server vtsls # Vue
      kotlin-language-server # Kotlin
      typescript-language-server
    ];
    extraLuaConfig = ''
      ${builtins.readFile ./options/basic-autocommand.lua}
      ${builtins.readFile ./options/basic-keymap.lua}
      ${builtins.readFile ./options/options.lua}
      ${builtins.readFile ./options/colorscheme.lua}
    '';
    plugins = with pkgs.vimPlugins; [
      # nvim-autopairs
      {
        plugin = nvim-autopairs;
        config = toLuaFile ./plugins/autopairs.lua;
      }
      # nvim-cmp
      cmp-nvim-lsp
      cmp-path
      {
        plugin = nvim-cmp;
        config = toLuaFile ./plugins/cmp.lua;
      }
      nvim-web-devicons
      # Mini Stuff
      {
        plugin = mini-pick;
        config = (toLuaFile ./plugins/mini.pick.lua);
      }
      mini-extra
      # LSP
      {
        plugin = nvim-lspconfig;
        config = (toLuaFile ./plugins/lsp.lua)
          + ( toLua buildVueConfig )
          + ( toLua buildJdtConfig )
        ;
      }
      # indent-blankline (Blank Line)
      {
        plugin = indent-blankline-nvim;
        config = toLuaFile ./plugins/indent-blankline.lua;
      }
      # Comment.nvim
      {
        plugin = comment-nvim;
        config = toLuaFile ./plugins/comment.lua;
      }
      # markdown-preview
      markdown-preview-nvim
      # Vscode colorscheme
      {
        plugin = pkgs.nur.repos.novel2430.nvim-vscode-colorscheme;
        config = toLuaFile ./plugins/vscode-nvim.lua;
      }
    ];
  };
}
