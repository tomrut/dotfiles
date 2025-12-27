{
  config,
  pkgs,
  lib,
  vimUtils,
  ...
}:

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
          "_" = [
            "squeeze_blanks"
            "trim_whitespace"
            "trim_newlines"
          ];
          javascript = {
            __unkeyed-1 = "prettierd";
            __unkeyed-2 = "prettier";
            timeout_ms = 2000;
            stop_after_first = true;
          };
          json = [ "jq" ];
          lua = [ "stylua" ];
          python = [
            "isort"
            "black"
          ];
          typescriptreact = [
            "prettierd"
            "prettier"
          ];
          html = [
            "prettierd"
            "prettier"
          ];
          css = [
            "prettierd"
            "prettier"
          ];
          rust = [ "rustfmt" ];
          sh = [ "shfmt" ];
          nix = [ "nixpkgs-fmt" ];
        };

        format_on_save = ''
          {
                     timeout_ms = 500,
                     lsp_format = "fallback",
                   }
        '';
        formatters = {
          shellcheck = {
            command = lib.getExe pkgs.shellcheck;
          };
          shfmt = {
            command = lib.getExe pkgs.shfmt;
          };
          shellharden = {
            command = lib.getExe pkgs.shellharden;
          };
          squeeze_blanks = {
            command = lib.getExe' pkgs.coreutils "cat";
          };
          nixpkgs-fmt = {
            command = lib.getExe pkgs.nixfmt-rfc-style;
          };
          prettier = {
            command = lib.getExe pkgs.nodePackages.prettier;
          };
        };
      };
    };

    crates.enable = true;
    friendly-snippets.enable = true;

    gitsigns = {
      enable = true;
      settings = {
        signs = {
          add = {
            text = "+";
          };
          change = {
            text = "~";
          };
          delete = {
            text = "_";
          };
          topdelete = {
            text = "‾";
          };
          changedelete = {
            text = "~";
          };
        };
      };
    };

    harpoon = {
      enable = true;
      enableTelescope = true;
    };

    highlight-colors = {
      enable = true;
      settings = {
        enable_named_colors = true;
        render = "virtual";
        virtual_symbol = "■";
      };
    };

    iron = {
      enable = true;
      settings = {
        highlight = {
          italic = true;
        };
        keymaps = {
          send_line = "<space>sl";
          send_motion = "<space>sc";
          visual_send = "<space>sc";
        };
        repl_definition = {
          python = {
            command = [
              "python3"
            ];
            format = {
              __raw = "require('iron.fts.common').bracketed_paste_python";
            };
          };
          sh = {
            command = [
              "zsh"
            ];
          };
        };
        repl_open_cmd = {
          __raw = "require(\"iron.view\").bottom(40)";
        };
        scratch_repl = true;
      };
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
        pyright.enable = false;

        tailwindcss.enable = true;
        terraformls.enable = false;
        ts_ls.enable = true;

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
      fromVscode = [ { } ];
    };

    navbuddy = {
      enable = true;
      settings = {
        lsp = {
          auto_attach = true;
        };
      };
    };

    nvim-autopairs.enable = true;
    nvim-surround.enable = true;

    nvim-tree = {
      enable = true;

      openOnSetupFile = true;
      settings = {
        auto_reload_on_write = true;
        update_focused_file.enable = true;
      };
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

    rustaceanvim = {
      enable = true;
    };

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
        incremental_selection = {
          enable = true;
          keymaps = {
            init_selection = false;
            node_decremental = "<bs>";
            node_incremental = "<C-space>";
            scope_incremental = "grc";
          };
        };
      };
    };

    treesitter-context = {
      enable = true;
      settings = {
        max_lines = 2;
      };
    };

    treesitter-refactor.enable = true;
    treesitter-textobjects.enable = true;

    ts-autotag.enable = true;
    ts-comments.enable = true;
    ts-context-commentstring.enable = true;

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
          {
            __unkeyed-1 = "<leader>r";
            desc = "Rust commands";
          }
        ];
      };
    };

    vimwiki = {
      enable = true;
      settings = {
        autowriteall = 0;
        global_ext = 0;
        hl_cb_checked = 1;
        hl_headers = 1;
        key_mappings = {
          all_maps = 1;
          global = 1;
          headers = 1;
        };
        list = [
          {
            ext = ".md";
            path = "~/docs/notes/";
            syntax = "markdown";
          }
        ];
        listsym_rejected = "✗";
        listsyms = "○◐●✓";
        use_calendar = 1;
      };
    };
  };
}
