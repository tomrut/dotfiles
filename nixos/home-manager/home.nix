{ pkgs, inputs, ... }:

{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./nixvim
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "tomek";
  home.homeDirectory = "/home/tomek";

  systemd.user.services = {

    mail_sync = {
      Unit = {
        Description = "mail sync service";
      };
      Service = {
        Type = "oneshot";
        ExecStart = toString (
          pkgs.writeShellScript "mail-sync-script" ''
            export gpg_cmd=${pkgs.gnupg}/bin/gpg
            ${pkgs.isync}/bin/mbsync -a
          ''
        );
      };
      Install.WantedBy = [ "default.target" ];
    };
  };

  systemd.user.services = {
    display_update_info = {
      Unit = {
        Description = "display update information";
      };
      Service = {
        Type = "oneshot";
        ExecStart = toString (
          pkgs.writeShellScript "call_check_updates" ''
            export PATH="''${PATH}:${pkgs.coreutils-full}/bin:${pkgs.libnotify}/bin"
            ${pkgs.bash}/bin/bash /home/tomek/bin/check_updates.sh
            ''
        );
      };
      Install.WantedBy = [ "default.target" ];
    };
  };


  systemd.user.services = {
    display_notifications = {
      Unit = {
        Description = "display notifications";
      };
      Service = {
        Type = "oneshot";
        ExecStart = toString (
          pkgs.writeShellScript "display_notifications" ''
            export PATH="''${PATH}:${pkgs.remind}/bin:${pkgs.libnotify}/bin"
            ${pkgs.bash}/bin/bash /home/tomek/bin/display_notif.sh
          ''
        );
      };
      Install.WantedBy = [ "default.target" ];
    };
  };

  systemd.user.timers = {

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

  systemd.user.timers = {

    display_notifications = {
      Unit.Description = "timer for display notifications";
      Timer = {
        Unit = "display_notifications";
        OnBootSec = "1m";
        OnUnitActiveSec = "3h";
      };
      Install.WantedBy = [ "timers.target" ];
    };

  };

  systemd.user.timers = {
    display_update_info = {
      Unit.Description = "timer to display update info";
      Timer = {
        Unit = "display_update_info";
        OnBootSec = "25m";
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
    pkgs.ripgrep
    pkgs.tree-sitter
    pkgs.gcc
    pkgs.mc
    pkgs.nodejs_24
    pkgs.yt-dlp
    pkgs.keepassxc
    pkgs.ripgrep
    pkgs.material-design-icons
    pkgs.nerd-fonts.fira-code
    pkgs.nerd-fonts.fira-mono
    pkgs.nerd-fonts.symbols-only
    pkgs.nerd-fonts.monaspace
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.unzip
    pkgs.mpg123
    pkgs.cargo
    pkgs.remind
    pkgs.gnupg
    pkgs.jdk21
    pkgs.maven
    pkgs.jetbrains.idea-community
    pkgs.nodePackages.pnpm
    pkgs.anki
    pkgs.neomutt
    pkgs.isync
    pkgs.pinentry
    pkgs.notify-desktop
    pkgs.flameshot
    pkgs.lazygit
    pkgs.fd
    pkgs.home-manager
    pkgs.yubioath-flutter
    pkgs.nixfmt-rfc-style
    pkgs.nvd
    pkgs.librewolf
    pkgs.feh
    pkgs.eza
    pkgs.wordbook
    pkgs.shotwell
    pkgs.jq
    pkgs.libnotify
    pkgs.gnome-clocks
    (pkgs.aspellWithDicts (dicts: with dicts; [ en en-computers pl ]))

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

  home.sessionPath = [ "$HOME/bin" ];
  programs.bash = {
    enable = true;
    bashrcExtra = ''
      export EDITOR="nvim";
    '';
  };

  programs.htop.enable = true;
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
      gst = "git status";
      gd = "git diff";
      gds = "git diff --staged";
      ga = "git add .";
      gcm = "git commit -m $1";
      gp = "git push";
      gP = "git pull";
      swayTree = "swaymsg -t get_tree";
      swayOutputs = "swaymsg -t get_outputs";
      bk = "~/bin/make_backup.sh";
      tmrs = "systemctl list-timers";
      reb = "sudo nixos-rebuild switch --no-write-lock-file";
      nvdiff = "nvd diff $(ls -d1v /nix/var/nix/profiles/system-*-link|tail -n 2)";
      m = "neomutt";
      f = "fzf --preview 'bat --color=always {}'";
      rfv = "rfv";
      l = "eza -bGF --header --git --color=always --group-directories-first --icons";
      ll = "eza -la --icons --octal-permissions --group-directories-first";
      llm = "eza -lbGd --header --git --sort=modified --color=always --group-directories-first --icons";
      la = "eza --long --all --group --group-directories-first";
      lx = "eza -lbhHigUmuSa@ --time-style=long-iso --git --color-scale --color=always --group-directories-first --icons";

      # specialty views
      lt = "eza --tree --level=2 --color=always --group-directories-first --icons";
      lld = "eza -a | grep -E '^\.'";
    };
    envExtra = ''
      export gpg_cmd=${pkgs.gnupg}/bin/gpg

      rfv() (
        RELOAD='reload:rg --column --color=always --smart-case {q} || :'
        OPENER='if [[ $FZF_SELECT_COUNT -eq 0 ]]; then
                  vim {1} +{2}     # No selection. Open the current line in Vim.
                else
                  vim +cw -q {+f}  # Build quickfix list for the selected items.
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


  programs.emacs = {
    enable = true;
    extraPackages = (
      epkgs:
      (with epkgs; [
        org
        org-superstar
        org-roam
        doct
      ])
    );

    extraConfig = builtins.readFile ./emacs_config.el;
  };

  # Let Home Manager install and manage itself.
  programs.git = {
    enable = true;
    userName = "tomrut";
    userEmail = "tomrut@localhost";

  };

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    # extensions = with pkgs.vscode-extensions; [
    #   dracula-theme.theme-dracula
    #   vscodevim.vim
    # ];
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

}
