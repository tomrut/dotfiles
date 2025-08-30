{
  imports = [
    ./opts.nix
    ./keymaps.nix
    ./plugins.nix
    ./debugging.nix
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
