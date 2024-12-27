{
  config,
  pkgs,
  lib,
  vimUtils,
  ...
}:

{

  programs.neovim =
    let
      toLua = str: "lua << EOF\n${str}\nEOF\n";
      toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
    in
    {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      vimdiffAlias = true;
      extraPackages = with pkgs; [
        tree-sitter
        nodePackages.typescript-language-server
        emmet-ls
        nixd
        vscode-langservers-extracted
        tailwindcss-language-server
        nodePackages.typescript-language-server
      ];

      extraLuaPackages = ps: [ ps.jsregexp ];

      plugins = with pkgs.vimPlugins; [

        {
          plugin = nvim-lspconfig;
          config = toLuaFile ./nvim/plugin/lsp.lua;
        }

        (nvim-treesitter.withPlugins (p: [
          p.tree-sitter-nix
          p.tree-sitter-bash
          p.tree-sitter-javascript
          p.tree-sitter-typescript
          p.tree-sitter-lua
          p.tree-sitter-json
          p.tree-sitter-css
          p.tree-sitter-html
          p.tree-sitter-java
          p.tree-sitter-markdown
        ]))
        telescope-nvim
        telescope-project-nvim
        lsp-zero-nvim
        mason-nvim
        emmet-vim
        mason-lspconfig-nvim
        {
          plugin = nvim-cmp;
          config = toLuaFile ./nvim/plugin/cmp.lua;
        }
        cmp-nvim-lsp
        cmp_luasnip
        cmp-buffer
        cmp-path
        nvim-tree-lua
        luasnip
        friendly-snippets
        nvim-web-devicons
        comment-nvim
        rose-pine
        harpoon
        undotree
        playground
        lazygit-nvim
        gitsigns-nvim
        lualine-nvim
        which-key-nvim
        lspsaga-nvim
        nvim-ts-autotag
        nvim-ts-context-commentstring
        lspkind-nvim
        nvim-treesitter-parsers.markdown
        nvim-treesitter-parsers.markdown_inline
        nvim-autopairs
        mini-icons
      ];

      extraConfig = builtins.concatStringsSep "\n" [
        ''
          lua <<EOF
          ${lib.strings.fileContents ./nvim/init.lua}
          ${lib.strings.fileContents ./nvim/remap.lua}
          ${lib.strings.fileContents ./nvim/set.lua}
          ${lib.strings.fileContents ./nvim/plugin/harpoon.lua}
          ${lib.strings.fileContents ./nvim/plugin/vcs.lua}
          ${lib.strings.fileContents ./nvim/plugin/undotree.lua}
          EOF
        ''
      ];

    };

}
