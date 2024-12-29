{
  programs.nixvim.opts = {

    updatetime = 100; # Faster completion

    number = true;
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
    spell = true;
    spelllang = "en_us";

    guicursor = "";
    nu = true;
    relativenumber = false;
    softtabstop = 2;
    wrap = false;
    backup = false;
    hlsearch = false;
    termguicolors = true;
    signcolumn = "yes";
    colorcolumn = "100";
  };
}
