{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    luaLoader.enable = true;
    globals.mapleader = " ";

    keymaps = [

      # general
      {
        mode = "n";
        key = "<C-q>";
        action = "<cmd>quit<cr>";
        options = {
          desc = "Quit";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<C-s>";
        action = "<cmd>w<cr>";
        options = {
          desc = "Save";
          silent = true;
        };
      }
      {
        mode = "i";
        key = "<C-s>";
        action = "<Esc>:w<cr>i";
        options = {
          desc = "Save";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<C-\\>";
        action = "<cmd>NvimTreeToggle<cr>";
        options = {
          desc = "NTree toggle";
          silent = true;
        };
      }
      {
        mode = "i";
        key = "<C-\\>";
        action = "<Esc>NvimTreeToggle<cr>i";
        options = {
          desc = "NTree toggle";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>gl";
        action = "<cmd>LazyGit<cr>";
        options = {
          desc = "Lazygit";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<F12>";
        action = "<cmd>silent !firefox %<cr>";
        options = {
          desc = "Lazygit";
          silent = true;
        };
      }
      {
        mode = "i";
        key = "<F12>";
        action = "<Esc>:w<cr>:silent !firefox %<cr>i";
        options = {
          desc = "Lazygit";
          silent = true;
        };
      }


      # buffers
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

      # gitsigns
      {
        mode = "n";
        key = "]c";
        action.__raw = ''
          function()
            if vim.wo.diff then
              vim.cmd.normal { ']c', bang = true }
            else
              require('gitsigns').nav_hunk 'next'
            end
          end
        '';
        options = {
          desc = "Jump to next git [C]hange";
        };
      }
      {
        mode = "n";
        key = "[c";
        action.__raw = ''
          function()
            if vim.wo.diff then
              vim.cmd.normal { '[c', bang = true }
            else
              require('gitsigns').nav_hunk 'prev'
            end
          end
        '';
        options = {
          desc = "Jump to previous git [C]hange";
        };
      }
      # Actions
      # visual mode
      {
        mode = "v";
        key = "<leader>hs";
        action.__raw = ''
          function()
            require('gitsigns').stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
          end
        '';
        options = {
          desc = "stage git hunk";
        };
      }
      {
        mode = "v";
        key = "<leader>hr";
        action.__raw = ''
          function()
            require('gitsigns').reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
          end
        '';
        options = {
          desc = "reset git hunk";
        };
      }
      # normal mode
      {
        mode = "n";
        key = "<leader>hs";
        action.__raw = ''
          function()
            require('gitsigns').stage_hunk()
          end
        '';
        options = {
          desc = "git [s]tage hunk";
        };
      }
      {
        mode = "n";
        key = "<leader>hr";
        action.__raw = ''
          function()
            require('gitsigns').reset_hunk()
          end
        '';
        options = {
          desc = "git [r]eset hunk";
        };
      }
      {
        mode = "n";
        key = "<leader>hS";
        action.__raw = ''
          function()
            require('gitsigns').stage_buffer()
          end
        '';
        options = {
          desc = "git [S]tage buffer";
        };
      }
      {
        mode = "n";
        key = "<leader>hu";
        action.__raw = ''
          function()
            require('gitsigns').undo_stage_hunk()
          end
        '';
        options = {
          desc = "git [u]ndo stage hunk";
        };
      }
      {
        mode = "n";
        key = "<leader>hR";
        action.__raw = ''
          function()
            require('gitsigns').reset_buffer()
          end
        '';
        options = {
          desc = "git [R]eset buffer";
        };
      }
      {
        mode = "n";
        key = "<leader>hp";
        action.__raw = ''
          function()
            require('gitsigns').preview_hunk()
          end
        '';
        options = {
          desc = "git [p]review hunk";
        };
      }
      {
        mode = "n";
        key = "<leader>hb";
        action.__raw = ''
          function()
            require('gitsigns').blame_line()
          end
        '';
        options = {
          desc = "git [b]lame line";
        };
      }
      {
        mode = "n";
        key = "<leader>hd";
        action.__raw = ''
          function()
            require('gitsigns').diffthis()
          end
        '';
        options = {
          desc = "git [d]iff against index";
        };
      }
      {
        mode = "n";
        key = "<leader>hD";
        action.__raw = ''
          function()
            require('gitsigns').diffthis '@'
          end
        '';
        options = {
          desc = "git [D]iff against last commit";
        };
      }

      # Toggles
      {
        mode = "n";
        key = "<leader>tb";
        action.__raw = ''
          function()
            require('gitsigns').toggle_current_line_blame()
          end
        '';
        options = {
          desc = "[T]oggle git show [b]lame line";
        };
      }
      {
        mode = "n";
        key = "<leader>tD";
        action.__raw = ''
          function()
            require('gitsigns').toggle_deleted()
          end
        '';
        options = {
          desc = "[T]oggle git show [D]eleted";
        };

      }

      # harpoon
      {
        mode = "n";
        key = "<leader>ea";
        action = ''<cmd>lua require("harpoon.mark").add_file()<CR>'';
        options = {
          desc = "Harpoon Add";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>eh";
        action = ''<cmd>Telescope harpoon marks<CR>'';
        options = {
          desc = "Harpoon Telescope Marks";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>eh";
        action = ''<cmd>Telescope harpoon marks<CR>'';
        options = {
          desc = "Harpoon Telescope Marks";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>en";
        action = ''<cmd>lua require("harpoon.ui").nav_next()<CR>'';
        options = {
          desc = "Harpoon Next Mark";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>ep";
        action = ''<cmd>lua require("harpoon.ui").nav_prev()<CR>'';
        options = {
          desc = "Harpoon Previous Mark";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>es";
        action = ''<cmd>lua require("harpoon.ui").nav_file(1)<CR>'';
        options = {
          desc = "Harpoon Mark 1";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>ed";
        action = ''<cmd>lua require("harpoon.ui").nav_file(2)<CR>'';
        options = {
          desc = "Harpoon Mark 2";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>ef";
        action = ''<cmd>lua require("harpoon.ui").nav_file(3)<CR>'';
        options = {
          desc = "Harpoon Mark 3";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>eg";
        action = ''<cmd>lua require("harpoon.ui").nav_file(4)<CR>'';
        options = {
          desc = "Harpoon Mark 4";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>em";
        action = ''<cmd>lua require("harpoon.ui").toggle_quick_menu()<CR>'';
        options = {
          desc = "Harpoon Menu";
          silent = true;
        };
      }

      # lsp
      {
        mode = "n";
        key = "<leader>lc";
        action = "<cmd>Lspsaga code_action<cr>";
        options = {
          desc = "Code Action";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>lff";
        action = "<cmd>Lspsaga finder<cr>";
        options = {
          desc = "Finder";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>lfi";
        action = "<cmd>Lspsaga finder imp<cr>";
        options = {
          desc = "Find Implementation";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>lfI";
        action = "<cmd>Lspsaga incoming_calls<cr>";
        options = {
          desc = "Find Incoming Calls";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>lfo";
        action = "<cmd>Lspsaga outgoing_calls<cr>";
        options = {
          desc = "Find Outgoing Calls";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>ln";
        action = "<cmd>Navbuddy<cr>";
        options = {
          desc = "Navbuddy";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>lr";
        action = "<cmd>Lspsaga rename<cr>";
        options = {
          desc = "Rename";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>lpd";
        action = "<cmd>Lspsaga peek_definition<cr>";
        options = {
          desc = "Peek Definition";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>lpt";
        action = "<cmd>Lspsaga peek_type_definition<cr>";
        options = {
          desc = "Peek Type Definition";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>lo";
        action = "<cmd>Lspsaga outline<cr>";
        options = {
          desc = "LSP Outline";
          silent = true;
        };
      }

      # search
      {
        mode = "n";
        key = "<leader>sb";
        action = "<cmd>Telescope buffers<CR>";
        options = {
          desc = "Buffers";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>sB";
        action = "<cmd>Telescope git_branches<CR>";
        options = {
          desc = "Git Branches";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>sf";
        action = "<cmd>Telescope find_files<CR>";
        options = {
          desc = "Files";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>sh";
        action = "<cmd>Telescope help_tags<CR>";
        options = {
          desc = "Help tags";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>st";
        action = "<cmd>Telescope live_grep<CR>";
        options = {
          desc = "Live Grep";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<leader>sp";
        action = "<cmd>Telescope projects<CR>";
        options = {
          desc = "Projects";
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
            {
              __unkeyed-1 = "<leader>t";
              desc = "Testing";
            }
          ];
        };
      };

    };
  };
}

