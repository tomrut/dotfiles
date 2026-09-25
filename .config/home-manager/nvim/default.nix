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
    extraConfigLua = ''
       vim.diagnostic.config({
         virtual_text = true,  -- show inline messages
         signs = true,         -- show signs in the gutter
         underline = true,     -- underline problematic text
         update_in_insert = false, -- don't update diagnostics while typing
         severity_sort = true,     -- sort diagnostics by severity
      })

    '';
  };
}
