{
  imports = [
    ./opts.nix
    ./keymaps.nix
    ./plugins.nix
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    luaLoader.enable = true;
    colorschemes.catppuccin.enable = true;

  };
}

