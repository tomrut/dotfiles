{ pkgs, pkgs-unstable, inputs, ... }:

let
  # codelldb_ext = pkgs.vscode-extensions.vadimcn.vscode-lldb;
  # codelldb_path = "${codelldb_ext}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb";
in
{

  #  imports = [
  #    inputs.nixvim.homeModules.nixvim
  #      ./nixvim
  #  ];

  home.packages = [
    pkgs.ripgrep
    # pkgs.gcc
    # pkgs.mc
    pkgs.nodejs_24
    pkgs.yt-dlp
    pkgs.mpv
    pkgs.keepassxc
    pkgs.libreoffice-still
    pkgs.material-design-icons
    pkgs.nerd-fonts.fira-code
    # pkgs.nerd-fonts.fira-mono
    # pkgs.nerd-fonts.symbols-only
    # pkgs.nerd-fonts.monaspace
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.unzip
    pkgs.mpg123
    pkgs.cargo
    pkgs.remind
    pkgs.gnupg

    # dev languages
    pkgs.jdk21
    pkgs.python3
    pkgs.maven
    # pkgs.jetbrains.idea-oss
    pkgs.pnpm
    pkgs.lazygit

    pkgs.rustc
    # pkgs.vscode-extensions.vadimcn.vscode-lldb

    pkgs.anki
    pkgs.neomutt
    pkgs.isync
    pkgs.pinentry-curses
    pkgs.notify-desktop
    pkgs.flameshot
    pkgs.fd
    pkgs.home-manager
    pkgs.yubioath-flutter
    pkgs.nixd
    pkgs.nil
    pkgs.nixfmt
    pkgs.nvd
    # pkgs.librewolf
    pkgs.feh
    # pkgs.eza
    pkgs.shotwell
    pkgs.jq
    pkgs.libnotify
    # probably most of the packages below were for neovim
    # pkgs.black
    # pkgs.isort
    # pkgs.rustfmt
    # pkgs.stylua
    # pkgs.prettierd
    # (pkgs.aspellWithDicts (
    #   dicts: with dicts; [
    #     en
    #     en-computers
    #     pl
    #   ]
    # ))
    #
    # necessary for lazynvim
    # pkgs.lua5_1
    # pkgs.luarocks-nix
    # pkgs.ast-grep
    pkgs.wget

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

  programs.neovim = {
    enable = true;
    plugins = [
      pkgs.vimPlugins.vimwiki
      pkgs.vimPlugins.vim-nix
      pkgs.vimPlugins.nvim-treesitter-parsers.nix
      pkgs.vimPlugins.nvim-tree-lua
      # pkgs.vimPlugins.markdown-nvim
      # pkgs.vimPlugins.nvim-treesitter-parsers.markdown
      #   pkgs.vimPlugins.nvim-treesitter.withAllGrammars
    ];
    coc.enable = true;
    extraConfig = ''
    set nocompatible
    filetype plugin on
    syntax on
    let g:vimwiki_list = [{'path': '~/docs/notes/',
                      \ 'syntax': 'markdown', 'ext': 'md'}]

    '';
    withPython3 = false;
    withRuby = false;
    initLua = ''
       vim.g.loaded_netrw = 1
       vim.g.loaded_netrwPlugin = 1

       -- optionally enable 24-bit colour
       vim.opt.termguicolors = true

       -- empty setup using defaults
       require("nvim-tree").setup()

       -- OR setup with a config

       ---@type nvim_tree.config
       local config = {
         sort = {
           sorter = "case_sensitive",
         },
         view = {
           width = 30,
         },
         renderer = {
           group_empty = true,
         },
         filters = {
           dotfiles = true,
         },
      }
      require("nvim-tree").setup(config)
      vim.g.mapleader = " "
      vim.keymap.set("n", "<C-q>", vim.cmd.quit)
      vim.keymap.set("n", "<C-s>", vim.cmd.w)
      vim.keymap.set("i", "<C-s>", '<Esc>:w<CR>i')
      vim.keymap.set("i", "<C-\\>", '<Esc>:NvimTreeToggle<CR>i')
      vim.keymap.set("n", "<C-\\>", vim.cmd.NvimTreeToggle)

      function _G.check_back_space()
        local col = vim.fn.col('.') - 1
        return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
      end
       
      local opts = { silent = true, expr = true, replace_keycodes = false }
      local keyset = vim.keymap.set
       
      keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
      keyset("i", "<S-TAB>", 'coc#pum#visible() ? coc#pum#prev(1) : "<C-h>"', opts)
      keyset("i", "<CR>", 'coc#pum#visible() ? coc#pum#confirm() : "<C-g>u<CR><c-r>=coc#on_enter()<CR>"', opts)
    '';
  };

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
    # "bin/codelldb".source = codelldb_path;

    "SDKS/OpenJDK21".source = "${pkgs.jdk21}";
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

  home.sessionPath = [ "$HOME/bin" ];
  programs.bash = {
    enable = true;
    bashrcExtra = ''
      export EDITOR="nvim"

    '';
  };

  programs.firefox = {
    enable = true;
    package = pkgs.firefox;
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      Preferences = {
        "cookiebanners.service.mode.privateBrowsing" = 2; # Block cookie banners in private browsing
        "cookiebanners.service.mode" = 2; # Block cookie banners
        "privacy.donottrackheader.enabled" = true;
        "privacy.fingerprintingProtection" = true;
        "privacy.resistFingerprinting" = true;
        "privacy.trackingprotection.emailtracking.enabled" = true;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.fingerprinting.enabled" = true;
        "privacy.trackingprotection.socialtracking.enabled" = true;
      };
    };
    configPath = ".mozilla/firefox";
  };

  programs.htop.enable = true;
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    autocd = true;
    shellAliases = {
      aa = "eval $(alias| wofi --dmenu | awk -F '[=]' '{print $1}')";
      mci = "mvn clean install -DskipTests";
      mcit = "mvn clean install";
      mcp = "mvn clean package -DskipTests";
      mcpt = "mvn clean package";
      lg = "lazygit";
      gst = "git status";
      gd = "git diff";
      gds = "git diff --staged";
      ga = "git add .";
      gcm = "git commit -m $1";
      gp = "git push";
      gP = "git pull";
      vim = "nvim";
      vi = "nvim";
      v = "nvim";
      swayTree = "swaymsg -t get_tree";
      swayOutputs = "swaymsg -t get_outputs";
      bk = "~/bin/make_backup.sh";
      tmrs = "systemctl list-timers";
      nreb = "sudo nixos-rebuild switch --no-write-lock-file";
      ncg = "sudo nix-collect-garbage -d";
      nhg = "home-manager generations";
      nin = "nix-store --query --requisites /run/current-system | cut -d- -f2- | sort | uniq";
      nvdiff = "nvd diff $(ls -d1v /nix/var/nix/profiles/system-*-link|tail -n 2)";
      m = "neomutt";
      f = "fzf --preview 'bat --color=always {}'";
      rfv = "rfv";
      # l = "eza -bGF --header --git --color=always --group-directories-first --icons";
      # ll = "eza -la --icons --octal-permissions --group-directories-first";
      # llm = "eza -lbGd --header --git --sort=modified --color=always --group-directories-first --icons";
      # la = "eza --long --all --group --group-directories-first";
      # lx = "eza -lbhHigUmuSa@ --time-style=long-iso --git --color-scale --color=always --group-directories-first --icons";

      # specialty views
      # lt = "eza --tree --level=2 --color=always --group-directories-first --icons";
      # lld = "eza -a | grep -E '^\.'";

      # battery charging
      chargeOnceBat0 = "sudo tlp chargeonce BAT0";
      chargeOnceBat1 = "sudo tlp chargeonce BAT1";
      chargeOnceAll = "chargeOnceBat0; chargeOnceBat1";
      chargeFullBat0 = "sudo tlp fullcharge BAT0";
      chargeFullBat1 = "sudo tlp fullcharge BAT1";
      chargeFullAll = "chargeFullBat0; chargeFullBat1";

    };
    envExtra = ''

      if [[ $(($(date +%-j) % 2)) == 1 ]]; then
        export current_drive=1
      else
        export current_drive=2
      fi

      export gpg_cmd=${pkgs.gnupg}/bin/gpg

      rfv() (
        RELOAD='reload:rg --column --color=always --smart-case {q} || :'
        OPENER='if [[ $FZF_SELECT_COUNT -eq 0 ]]; then
                  nvim {1} +{2}     # No selection. Open the current line in Vim.
                else
                  nvim +cw -q {+f}  # Build quickfix list for the selected items.
                fi'
        fzf --disabled --ansi --multi \
            --bind "start:$RELOAD" --bind "change:$RELOAD" \
            --bind "enter:become:$OPENER" \
            --bind "ctrl-o:execute:$OPENER" \
            --bind 'alt-a:select-all,alt-d:deselect-all,ctrl-/:toggle-preview' \
            --delimiter : \
            --preview 'bat --style=full --color=always --highlight-line {2} {1}' \
            --preview-window '~4,+{2}+4/3,<80(up)' \
            --query "$*"
      )

    '';
  };

  programs.fzf = {
    colors = {
      bg = "#1e1e1e";
      "bg+" = "#1e1e1e";
      fg = "#d4d4d4";
      "fg+" = "#d4d4d4";
    };
    enable = true;
    enableZshIntegration = true;
    changeDirWidgetCommand = "fd --type d";
    changeDirWidgetOptions = [
      "--preview 'tree -C {} | head -200'"
    ];

    fileWidgetCommand = ''
      fd --type f
    '';
    fileWidgetOptions = [
      "--preview 'head {}'"
    ]; 

  };

  programs.bat.enable = true;

  # Let Home Manager install and manage itself.
  programs.git = {
    enable = true;
    settings = {
      user.name = "tomrut";
      user.email = "tomrut@localhost";
    };
  };

  home.shellAliases = {
    kal = "remind -n1 -c -@ ~/.reminders";
    kal2 = "remind -n1 -c2 -@ ~/.reminders";
    lclassic = "mpg123 https://rs101-krk.rmfstream.pl/RMFCLASSIC48";
    lsoundtracks = "mpg123 https://kathy.torontocast.com:1190/";
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true; # see note on other shells below
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.zathura = {
    enable = true;
  };

  programs.zed-editor = {
    enable = true;
    package = pkgs-unstable.zed-editor;
    userSettings = {
      project_panel = {
        dock = "left";
      };

      base_keymap = "JetBrains";
      ui_font_size = 16;
      buffer_font_size = 15;
      max_tabs = 6;

      theme = {
        mode = "system";
        light = "Ayu Light";
        dark = "Ayu Dark";
      };

      telemetry = {
        # Send debug info like crash reports.
        diagnostics = false;
        # Send anonymized usage data like what languages you're using Zed with.
        metrics = false;
        # Allow sending requests to Anthropic models that cannot be offered with
        # Zero Data Retention
        anthropic_retention = false;
      };
    };

  };

  # programs.vscode = {
  #   enable = true;
  #   package = pkgs.vscodium;
  #   profiles.default.extensions = with pkgs.vscode-extensions; [
  #     dracula-theme.theme-dracula
  #     firefox-devtools.vscode-firefox-debug
  #   ];
  # };
}
