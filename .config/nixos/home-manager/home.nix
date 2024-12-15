{
  config,
  pkgs,
  lib,
  vimUtils,
  ...
}:

#

{

  imports = [ ./nvim.nix ];

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

    sync_share_sync = {
      Unit = {
        Description = "sync_share sync service";
      };
      Service = {
        Type = "oneshot";
        ExecStart = toString (
          pkgs.writeShellScript "sync_share-sync-script" ''
            export PATH=/run/wrappers/bin:/home/tomek/.nix-profile/bin:/nix/profile/bin:/home/tomek/.local/state/nix/profile/bin:/etc/profiles/per-user/tomek/bin:/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin:/home/tomek/bin
            ${pkgs.bash}/bin/bash /home/tomek/bin/sync_org.sh

            ${pkgs.bash}/bin/bash /home/tomek/bin/make_backup.sh
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
    
    sync_share_sync = {
      Unit.Description = "timer for sync_share_sync service";
      Timer = {
        Unit = "sync_share_sync";
        OnBootSec = "14m";
        OnUnitActiveSec = "1d";
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
    #(pkgs.nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono"  "Monoid" "DroidSansMono" "MPlus" "NerdFontsSymbolsOnly" ]; })
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
    pkgs.md4c
    pkgs.lua-language-server
    pkgs.home-manager
    pkgs.yubioath-flutter

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

  programs.broot = {
    enable = true;
    enableBashIntegration = true;
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
    extraPackages = (
      epkgs:
      (with epkgs; [
        org
        org-superstar
        nix-mode
        nix-ts-mode
      ])
    );

    extraConfig = ''
      (require 'org-superstar)
      (add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))
    '';
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

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    extensions = with pkgs.vscode-extensions; [ ];
  };

  programs.zathura = {
    enable = true;
  };

}
