{
  pkgs,
  inputs,
  lib,
  ...
}:

{
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./nvim
  ];
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "tomek";
  home.homeDirectory = "/home/tomek";
  home.sessionVariables.SHELL = "${pkgs.zsh}/bin/zsh";
  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "26.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    nixgl.nixGLIntel
    nil
    nixd
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello
    mc
    typescript-language-server
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
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/tomek/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.zed-editor = {
    enable = true;

    userSettings = {
      project_panel = {
        dock = "left";
      };

      base_keymap = "JetBrains";
      ui_font_size = 16;
      buffer_font_size = 16;
      max_tabs = 6;

      theme = {
        mode = "system";
        light = "Ayu Light";
        dark = "Ayu Dark";
      };

      experimental.theme_overrides = {
        editor.document_highlight.bracket_background = "#ff0001";
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

      node = {
        path = lib.getExe pkgs.nodejs;
        npm_path = lib.getExe' pkgs.nodejs "npm";
      };

      lsp = {
        # rust-analyzer = {
        #   binary = {
        #     # path = lib.getExe pkgs.rust-analyzer;
        #     path_lookup = true;
        #   };
        # };

        nixd = {
          binary = {
            path_lookup = true;
          };
        };

      };

      languages = {
        "Nix" = {
          format_on_save = "on";
          formatter = {
            external = {
              command = "nixfmt";
              arguments = [
                "--filename"
                "{buffer_path}"
              ];
            };
          };
        };
      };
    };

    extensions = [
      "nix"
      "html"
      "tsgo"
      # react-typescript-snippets
    ];

  };

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
      zed = "nixGLIntel zeditor";
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
      . "$HOME/.nix-profile/etc/profile.d/nix.sh"
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

  programs.lazygit.enable = true;

  programs.fzf = {
    colors = {
      bg = "#1e1e1e";
      "bg+" = "#1e1e1e";
      fg = "#d4d4d4";
      "fg+" = "#d4d4d4";
    };
    enable = true;
    enableZshIntegration = true;
    changeDirWidget = {
      command = "fd --type d";
      options = [
        "--preview 'tree -C {} | head -200'"
      ];
    };

    fileWidget = {
      command = ''
        fd --type f
      '';
      options = [
        "--preview 'head {}'"
      ];
    };

  };

  services.home-manager.autoUpgrade = {
    enable = true;
    frequency = "daily";
  };

  nix.gc = {
    dates = "daily";
    automatic = true;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
