{
  pkgs,
  ...
}:

{
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
      zeditor = "nixGLIntel ${pkgs.zed-editor}/bin/zeditor";
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

      #autoload -Uz vcs_info
      #precmd() { vcs_info }

      #zstyle ':vcs_info:git:*' formats '%b '
      #setopt PROMPT_SUBST

      #PROMPT='%F{green}%n@%m%f%F{blue}%~%f %F{red}''${vcs_info_msg_0_}%f➤ '
      PROMPT='%F{green}%n@%m%f %F{blue}%~%f %F{red}➤%f '

      # emac like keyboard bindings for foot
      bindkey -e
    '';
  };
}
