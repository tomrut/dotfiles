{
  programs.nixvim.plugins = {

    bufferline.enable = true;

    cmp = {
      enable = true;
      autoEnableSources = true;

      settings = {


        mapping = {
          "<C-d>" = "cmp.mapping.scroll_docs(-4)";
          "<C-f>" = "cmp.mapping.scroll_docs(4)";
          "<C-Space>" = "cmp.mapping.complete()";
          "<C-e>" = "cmp.mapping.close()";
          "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
          "<CR>" = "cmp.mapping.confirm({ select = true })";
        };

        snippet = {
          expand = ''
            function(args)
            require("luasnip").lsp_expand(args.body)
            end
          '';
        };

        sources = [
          { name = "nvim_lsp"; }
          {
            name = "luasnip";
            option = {
              show_autosnippets = true;
            };
          }
          { name = "path"; }
          { name = "buffer"; }
        ];
      };
    };

    conform-nvim = {
      enable = true;

      settings = {
        formatters_by_ft = {
          "_" = [ "trim_whitespace" ];
          javascript = [
            [
              "prettierd"
              "prettier"
            ]
          ];
          json = [ "jq" ];
          lua = [ "stylua" ];
          python = [
            "isort"
            "black"
          ];
          rust = [ "rustfmt" ];
          sh = [ "shfmt" ];
          terraform = [ "terraform_fmt" ];
        };

        format_on_save = ''
          function(bufnr)
          local ignore_filetypes = { "helm" }
          if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
          return
          end

          -- Disable with a global or buffer-local variable
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
          end

          -- Disable autoformat for files in a certain path
          local bufname = vim.api.nvim_buf_get_name(bufnr)
          if bufname:match("/node_modules/") then
          return
          end
          return { timeout_ms = 1000, lsp_fallback = true }
          end
        '';
      };
    };


    gitsigns = {
      enable = true;
      settings = {
        signs = {
          add = { text = "+"; };
          change = { text = "~"; };
          delete = { text = "_"; };
          topdelete = { text = "‾"; };
          changedelete = { text = "~"; };
        };
      };
    };

    harpoon = {
      enable = true;
      enableTelescope = true;
    };

    lsp = {
      enable = true;
      inlayHints = true;

      servers = {
        ansiblels.enable = false;
        bashls.enable = true;
        ccls.enable = true;
        cssls.enable = true;
        dockerls.enable = false;
        earthlyls.enable = false;
        emmet_ls.enable = true;
        golangci_lint_ls.enable = false;
        gopls.enable = false;
        html.enable = true;
        java_language_server.enable = false;
        jdtls.enable = false;
        jsonls.enable = true;
        lua_ls.enable = true;
        nushell.enable = false;
        pylsp.enable = true;
        pylyzer.enable = false;
        ruff_lsp.enable = false;
        tailwindcss.enable = true;
        terraformls.enable = true;
        ts_ls.enable = true;
        veryl_ls.enable = false;
        zls.enable = false;

        helm_ls = {
          enable = true;
          filetypes = [ "helm" ];
        };

        nixd = {
          enable = true;

          settings = {
            formatting.command = [ "nixpkgs-fmt" ];
            nixpkgs.expr = "import <nixpkgs> {}";
          };
        };

        yamlls = {
          enable = true;
          filetypes = [ "yaml" ];
        };
      };
    };

    lazygit.enable = true;

    lspsaga.enable = true;

    lualine.enable = true;

    luasnip = {
      enable = true;
      fromVscode = [{ }];
    };

    navbuddy = {
      enable = true;
      lsp.autoAttach = true;
    };

    nvim-tree = {
      enable = true;

      openOnSetupFile = true;
      autoReloadOnWrite = true;
    };

    octo = {
      enable = false;
    };

    project-nvim = {
      enable = true;
      enableTelescope = true;

      settings = {
        manual_mode = true;

        patterns = [
          ".bzr"
          ".git"
          ".hg"
          ".svn"
          "Cargo.toml"
          "Makefile"
          "_darcs"
          "flake.nix"
          "flake.nix"
          "go.mod"
          "package.json"
          "pom.xml"
        ];
      };
    };

    rainbow-delimiters.enable = true;

    telescope = {
      enable = true;

      extensions = {
        fzy-native.enable = true;
        ui-select.enable = true;

        frecency = {
          enable = true;

          settings = {
            db_safe_mode = false;
          };
        };
      };
    };

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

    web-devicons.enable = true;

    which-key = {
      enable = true;
      settings = {
        spec = [
          {
            __unkeyed-1 = "<leader>b";
            desc = "Buffers";
          }
          {
            __unkeyed-1 = "<leader>e";
            desc = "Harpoon";
          }
          {
            __unkeyed-1 = "<leader>g";
            desc = "Git";
          }
          {
            __unkeyed-1 = "<leader>h";
            desc = "Gitsigns";
          }
          {
            __unkeyed-1 = "<leader>l";
            desc = "LSP";
          }
          {
            __unkeyed-1 = "<leader>s";
            desc = "Search using Telescope";
          }
        ];
      };
    };

    zk = {
      enable = true;

      settings = { picker = "telescope"; };
    };

  };
}
