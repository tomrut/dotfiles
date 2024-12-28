{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    luaLoader.enable = true;

    globals.mapleader = " ";

    keymaps = [

      {
        mode = "n";
        key = "<leader>bd";
        action = "<cmd>lua require('bufdelete').bufdelete(0, true)<cr>";
        options = {
          desc = "Close Buffer";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>bs";
        action = "<cmd>Telescope buffers<cr>";
        options = {
          desc = "Switch Buffer";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "[b";
        action = "<cmd>bprevious<cr>";
        options = {
          desc = "Open previous buffer";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "]b";
        action = "<cmd>bnext<cr>";
        options = {
          desc = "Move to next buffer";
          silent = true;
        };
      }

    ];

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

      cmp = {
        enable = true;
        autoEnableSources = true;

        settings = {
          mapping = {
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-e>" = "cmp.mapping.abort()";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-n>" = "cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert }";
            "<C-u>" = "cmp.mapping.complete({})";
            "<C-p>" = "cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert }";
            "<C-y>" =
              ''cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert }, {"i", "c"})'';
            "<C-space>" = ''
              cmp.mapping {
                i = cmp.mapping.complete(),
                c = function(
                  _ --[[fallback]]
                  )
                  if cmp.visible() then
                  if not cmp.confirm { select = true } then
                  return
                  end
                  else
                  cmp.complete()
                  end
                  end,
                }
            '';
            "<tab>" = "cmp.config.disable";
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
            go = [
              "goimports"
              "golines"
              "gofmt"
              "gofumpt"
            ];
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

      lualine.enable = true;

      luasnip = {
        enable = true;
        fromVscode = [{ }];
      };

      neorg = {
        enable = true;

        extraOptions = {
          load = {
            "core.defaults" = {
              __empty = null;
            };
            "core.dirman" = {
              config = {
                workspaces = {
                  home = "~/org/todo/home";
                  work = "~/org/todo/work";
                };
              };
            };
          };
        };
      };

      nvim-tree = {
        enable = true;

        openOnSetupFile = true;
        autoReloadOnWrite = true;
      };

      octo = {
        enable = true;
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

      smartcolumn = {
        enable = true;

        settings = {
          colorcolumn = "80";
          scope = "file";

          disable_filetypes = [
            "NvimTree"
            "Trouble"
            "checkhealth"
            "help"
            "lazy"
            "lspinfo"
            "noice"
          ];
        };
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
        };
      };

      treesitter-context = {
        enable = true;
        settings = {
          max_lines = 2;
        };
      };

      trouble = {
        enable = true;

        settings = {
          auto_refresh = true;
          focus = true;
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
              __unkeyed-1 = "<leader>d";
              desc = "Debugging";
            }
            {
              __unkeyed-1 = "<leader>dB";
              desc = "Breakpoint";
            }
            {
              __unkeyed-1 = "<leader>ds";
              desc = "Step";
            }
            {
              __unkeyed-1 = "<leader>g";
              desc = "Git";
            }
            {
              __unkeyed-1 = "<leader>gp";
              desc = "Git Push";
            }
            {
              __unkeyed-1 = "<leader>gP";
              desc = "Github PR";
            }
            {
              __unkeyed-1 = "<leader>gw";
              desc = "Git Worktree";
            }
            {
              __unkeyed-1 = "<leader>h";
              desc = "Harpoon";
            }
            {
              __unkeyed-1 = "<leader>l";
              desc = "LSP";
            }
            {
              __unkeyed-1 = "<leader>lb";
              desc = "Bacon";
            }
            {
              __unkeyed-1 = "<leader>lf";
              desc = "LSP Finder";
            }
            {
              __unkeyed-1 = "<leader>lp";
              desc = "LSP Peek";
            }
            {
              __unkeyed-1 = "<leader>lR";
              desc = "Rust LSP";
            }
            {
              __unkeyed-1 = "<leader>lrm";
              desc = "Rust LSP Move Item";
            }
            {
              __unkeyed-1 = "<leader>s";
              desc = "Search using Telescope";
            }
            {
              __unkeyed-1 = "<leader>t";
              desc = "Testing";
            }
            {
              __unkeyed-1 = "<leader>z";
              desc = "Zettelkasten";
            }
          ];
        };
      };

    };
  };

}
