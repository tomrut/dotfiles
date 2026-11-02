{
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

}
