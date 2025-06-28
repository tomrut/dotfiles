{ pkgs, inputs, ... }:

{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./nixvim
  ];


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
