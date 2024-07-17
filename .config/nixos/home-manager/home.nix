{ config, pkgs, lib, vimUtils, ... }:

#

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "tomek";
  home.homeDirectory = "/home/tomek";

  systemd.user.services = {
    reminders_status = {
      Unit = {
        Description = "reminders notification service";
      };
      Service = {
        Type = "oneshot";
        ExecStart = toString (
          pkgs.writeShellScript "reminders-status-script" ''
            ${pkgs.bash}/bin/bash "/home/tomek/bin/display_notif.sh";
          ''
        );
      };
      Install.WantedBy = [ "default.target" ];
    };
    mail_sync = {
      Unit = {
        Description = "mail sync service";
      };
      Service = {
        Type = "oneshot";
        ExecStart = toString (
          pkgs.writeShellScript "mail-sync-script" ''
            ${pkgs.isync}/bin/mbsync -a
          ''
        );
      };
      Install.WantedBy = [ "default.target" ];
    };
  };

  systemd.user.timers = {
    reminders_status = {
      Unit.Description = "timer for reminders_status service";
      Timer = {
        Unit = "reminders_status";
        OnBootSec = "10m";
        OnUnitActiveSec = "6h";
      };
      Install.WantedBy = [ "timers.target" ];
    };

     mail_sync = {
      Unit.Description = "timer for mail_sync service";
      Timer = {
        Unit = "mail_sync";
        OnBootSec = "10m";
        OnUnitActiveSec = "10m";
      };
      Install.WantedBy = [ "timers.target" ];
    };
  };

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
    pkgs.nodejs_22
    pkgs.yt-dlp
    pkgs.keepassxc
    pkgs.ripgrep
    pkgs.material-design-icons
    pkgs.nerdfonts
    pkgs.unzip
    pkgs.mpg123
    pkgs.cargo
    pkgs.remind
    pkgs.gnupg
    pkgs.gxmessage
    pkgs.jdk21
    pkgs.maven
    pkgs.jetbrains.idea-community
    pkgs.nodePackages.pnpm
    pkgs.neofetch
    pkgs.anki
    pkgs.neomutt
    pkgs.isync
    pkgs.pinentry
    pkgs.notify-desktop
    pkgs.inkscape
    pkgs.flameshot
    pkgs.lazygit
    pkgs.fd

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

  programs.bash = {
    enable = true;

    bashrcExtra = ''
      export EDITOR="nvim";
      export TERMINAL="kitty";
    '';
  };

  programs.broot = {
    enable = true;
    enableBashIntegration = true;
  };

  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    settings = {
      font_size = 12;
      font_family = "JetBrainsMono";
      copy_on_select = "yes";
      cursor_shape = "block";
      cursor_blink_interval = 0;
      enable_audio_bell = "no";
      shell = "zsh";
      editor = "nvim";
      window_padding_width = 5;
      tab_title_template = "{index}";
      tab_bar_style = "powerline";
      tab_powerline_style = "angled";
      enabled_layouts = "vertical";
    };
  };

  programs.btop.enable = true;
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    autocd = true;
    shellAliases = {
      mci = "mvn clean install -DskipTests";
      mcit = "mvn clean install";
      mcp = "mvn clean package -DskipTests";
      mcpt = "mvn clean package";
      lg = "lazygit";
    };

    oh-my-zsh = {
      enable = true;
      theme = "random";
      plugins = [
        "git"
        "vi-mode"
      ];
    };
  };
  programs.fzf.enable = true;
  programs.bat.enable = true;

  # Let Home Manager install and manage itself.
  programs.git = {
    enable = true;
    userName = "tomrut";
    userEmail = "tomrut@localhost";

  };

  programs.emacs = {
    enable = true;
    extraPackages = epkgs: [
      epkgs.org
    ];
  };

  home.shellAliases = {
    kal = "remind -n1 -c -@ .reminders";
    kal2 = "remind -n1 -c2 -@ .reminders";
    lclassic = "mpg123 https://rs101-krk.rmfstream.pl/RMFCLASSIC48";
    lsoundtracks = "mpg123 https://kathy.torontocast.com:1190/";
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true; # see note on other shells below
    nix-direnv.enable = true;

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
          # config = toLuaFile ./nvim/plugin/cmp.lua;
        }
        cmp-nvim-lsp
        nvim-tree-lua
        luasnip
        friendly-snippets
        nvim-web-devicons
        comment-nvim
        rose-pine
        harpoon
        undotree
        playground
        lazygit-nvim
        vim-fugitive
        gitsigns-nvim
        lualine-nvim
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
          ${lib.strings.fileContents ./nvim/plugin/harpoon.lua}
          ${lib.strings.fileContents ./nvim/plugin/fugitive.lua}
          ${lib.strings.fileContents ./nvim/plugin/undotree.lua}
          EOF
        ''

        ''
          lua <<EOF
            require('lualine').setup({
                options = { theme = 'dracula' }
            })
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

        ''
          lua <<EOF
            require('gitsigns').setup {
              on_attach = function(bufnr)
                local gitsigns = require('gitsigns')

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map('n', ']c', function()
                  if vim.wo.diff then
                    vim.cmd.normal({']c', bang = true})
                  else
                    gitsigns.nav_hunk('next')
                  end
                end)

                map('n', '[c', function()
                  if vim.wo.diff then
                    vim.cmd.normal({'[c', bang = true})
                  else
                    gitsigns.nav_hunk('prev')
                  end
                end)

                -- Actions
                map('n', '<leader>hs', gitsigns.stage_hunk)
                map('n', '<leader>hr', gitsigns.reset_hunk)
                map('v', '<leader>hs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
                map('v', '<leader>hr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
                map('n', '<leader>hS', gitsigns.stage_buffer)
                map('n', '<leader>hu', gitsigns.undo_stage_hunk)
                map('n', '<leader>hR', gitsigns.reset_buffer)
                map('n', '<leader>hp', gitsigns.preview_hunk)
                map('n', '<leader>hb', function() gitsigns.blame_line{full=true} end)
                map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
                map('n', '<leader>hd', gitsigns.diffthis)
                map('n', '<leader>hD', function() gitsigns.diffthis('~') end)
                map('n', '<leader>td', gitsigns.toggle_deleted)

                -- Text object
                map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
              end
            } 

          EOF
        ''
      ];

    };

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [
    ];
  };

  programs.zathura = {
    enable = true;
  };

}
