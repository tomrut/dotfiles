{ config, pkgs, lib, vimUtils, ... }:

#

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "tomek";
  home.homeDirectory = "/home/tomek";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    pkgs.lynx
    pkgs.ripgrep    
    pkgs.gcc
    pkgs.mc
    pkgs.nodejs_21
    pkgs.yt-dlp
    pkgs.keepassxc
    pkgs.htop
    pkgs.ripgrep
    pkgs.nerdfonts
    pkgs.unzip
    pkgs.mpg123
    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/.screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/tomek/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
     EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName  = "tomrut";
    userEmail = "tomrut@localhost";
  };

  programs.neovim = 
  let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  in
  {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraPackages = with pkgs; [
        tree-sitter
        nodePackages.typescript-language-server
        emmet-ls
        vscode-langservers-extracted
        tailwindcss-language-server
        nodePackages.typescript-language-server
    ];

    plugins = with pkgs.vimPlugins; [
      
      {
          plugin = nvim-lspconfig;
          config = toLuaFile ./nvim/plugin/lsp.lua;
      }

      (nvim-treesitter.withPlugins (p: [
        p.tree-sitter-nix
        p.tree-sitter-bash
        p.tree-sitter-javascript
        p.tree-sitter-typescript
        p.tree-sitter-lua
        p.tree-sitter-json
        p.tree-sitter-css
        p.tree-sitter-html
        p.tree-sitter-java
      ]))
      telescope-nvim
      telescope-project-nvim
      lsp-zero-nvim
      mason-nvim
      emmet-vim
      mason-lspconfig-nvim
      {
          plugin = nvim-cmp;
          config = toLuaFile ./nvim/plugin/cmp.lua;
      }
      cmp-nvim-lsp
      nvim-tree-lua
      luasnip
      nvim-web-devicons
      comment-nvim
      rose-pine
      harpoon
      undotree
      playground
    ];

    extraConfig = builtins.concatStringsSep "\n" [
      ''
        let mapleader = "\<Space>"
        nnoremap <leader>ff <cmd>Telescope find_files<cr>
        nnoremap <leader>fg <cmd>Telescope live_grep<cr>
        nnoremap <leader>fb <cmd>Telescope buffers<cr>
        nnoremap <leader>fh <cmd>Telescope help_tags<cr>
        nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
        nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
        nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
        nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

        nnoremap <C-q> <cmd>quit<cr>
        nnoremap <C-s> <cmd>w<cr>
        nnoremap <C-\> <cmd>NvimTreeToggle<cr>

        imap <C-s> <esc>:w<cr>i
        imap <C-\> <esc>:NvimTreeToggle<cr>i
      ''

      ''
      lua <<EOF
      require("nvim-web-devicons").setup {}
      require("nvim-tree").setup {}
      ${lib.strings.fileContents ./remap.lua}
      ${lib.strings.fileContents ./set.lua}
      ${lib.strings.fileContents ./nvim/plugin/colors.lua}
      EOF
      ''

      ''
      lua <<EOF
        require("nvim-tree").setup()
        require('Comment').setup({
            ignore = '^$',
            toggler = {
                line = '<leader>cc',
                block = '<leader>bc',
            },
            opleader = {
                line = '<leader>c',
                block = '<leader>b',
            },
        })
      EOF
      ''
    ];

  };
}
