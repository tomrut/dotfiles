{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    luaLoader.enable = true;

    opts = {
      updatetime = 100; # Faster completion

      number = true;
      relativenumber = true;
      splitbelow = true;
      splitright = true;
      scrolloff = 4;

      autoindent = true;
      clipboard = "unnamedplus";
      expandtab = true;
      shiftwidth = 2;
      smartindent = true;
      tabstop = 2;

      ignorecase = true;
      incsearch = true;
      smartcase = true;
      wildmode = "list:longest";

      swapfile = false;
      undofile = true; # Build-in persistent undo

      # termguicolors = lib.mkForce pkgs.stdenv.isLinux;
    };

    colorschemes.catppuccin.enable = true;

    plugins = {
      bufferline.enable = true;
      web-devicons.enable = true;
      treesitter = {
        enable = true;
        nixGrammars = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
        };
      };
      treesitter-context = {
        enable = true;
        settings = {
          max_lines = 2;
        };
      };
      lualine.enable = true;

      nvim-tree = {
        enable = true;
        openOnSetupFile = true;
        autoReloadOnWrite = true;
      };
      rainbow-delimiters.enable = true;
    };
  };

}
