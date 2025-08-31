{
  programs.nixvim = {

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
        key = "<C-S>";
        action = "<cmd>wa<cr>";
        options = {
          desc = "Save all";
          silent = true;
        };
      }
      {
        mode = "i";
        key = "<C-S>";
        action = "<Esc>:wa<cr>i";
        options = {
          desc = "Save all";
          silent = true;
        };
      }
      {
        mode = "n";
        key = "<M-\\>";
        action = "<cmd>NvimTreeToggle<cr>";
        options = {
          desc = "NTree toggle";
          silent = true;
        };
      }
      {
        mode = "i";
        key = "<M-\\>";
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
        action = "<cmd>silent !librewolf %<cr>";
        options = {
          desc = "Lazygit";
          silent = true;
        };
      }
      {
        mode = "i";
        key = "<F12>";
        action = "<Esc>:w<cr>:silent !librewolf %<cr>i";
        options = {
          desc = "Lazygit";
          silent = true;
        };
      }

      # buffers
      {
        mode = "n";
        key = "<leader>bd";
        action = "<cmd>bdelete<cr>";
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
        key = "<leader>td";
        action = "<cmd>lua vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text })<CR>";
        options = {
          desc = "[T]oggle display diagnostic";
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
      {
        mode = "n";
        key = "<leader>ld";
        action = "<cmd>lua vim.diagnostic.open_float()<cr>";
        options = {
          desc = "Open diagnostic float";
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

      # debug

      {
        mode = "n";
        key = "<leader>dB";
        action = "\n        <cmd>lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>\n      ";
        options = {
          silent = true;
          desc = "Breakpoint Condition";
        };
      }
      {
        mode = "n";
        key = "<leader>db";
        action = ":DapToggleBreakpoint<cr>";
        options = {
          silent = true;
          desc = "Toggle Breakpoint";
        };
      }
      {
        mode = "n";
        key = "<leader>dc";
        action = ":DapContinue<cr>";
        options = {
          silent = true;
          desc = "Continue";
        };
      }
      {
        mode = "n";
        key = "<leader>da";
        action = "<cmd>lua require('dap').continue({ before = get_args })<cr>";
        options = {
          silent = true;
          desc = "Run with Args";
        };
      }
      {
        mode = "n";
        key = "<leader>dC";
        action = "<cmd>lua require('dap').run_to_cursor()<cr>";
        options = {
          silent = true;
          desc = "Run to cursor";
        };
      }
      {
        mode = "n";
        key = "<leader>dg";
        action = "<cmd>lua require('dap').goto_()<cr>";
        options = {
          silent = true;
          desc = "Go to line (no execute)";
        };
      }
      {
        mode = "n";
        key = "<leader>di";
        action = ":DapStepInto<cr>";
        options = {
          silent = true;
          desc = "Step into";
        };
      }
      {
        mode = "n";
        key = "<leader>dj";
        action = "\n        <cmd>lua require('dap').down()<cr>\n      ";
        options = {
          silent = true;
          desc = "Down";
        };
      }
      {
        mode = "n";
        key = "<leader>dk";
        action = "<cmd>lua require('dap').up()<cr>";
        options = {
          silent = true;
          desc = "Up";
        };
      }
      {
        mode = "n";
        key = "<leader>dl";
        action = "<cmd>lua require('dap').run_last()<cr>";
        options = {
          silent = true;
          desc = "Run Last";
        };
      }
      {
        mode = "n";
        key = "<leader>do";
        action = ":DapStepOut<cr>";
        options = {
          silent = true;
          desc = "Step Out";
        };
      }
      {
        mode = "n";
        key = "<leader>dO";
        action = ":DapStepOver<cr>";
        options = {
          silent = true;
          desc = "Step Over";
        };
      }
      {
        mode = "n";
        key = "<leader>dp";
        action = "<cmd>lua require('dap').pause()<cr>";
        options = {
          silent = true;
          desc = "Pause";
        };
      }
      {
        mode = "n";
        key = "<leader>dr";
        action = ":DapToggleRepl<cr>";
        options = {
          silent = true;
          desc = "Toggle REPL";
        };
      }
      {
        mode = "n";
        key = "<leader>ds";
        action = "<cmd>lua require('dap').session()<cr>";
        options = {
          silent = true;
          desc = "Session";
        };
      }
      {
        mode = "n";
        key = "<leader>dt";
        action = ":DapTerminate<cr>";
        options = {
          silent = true;
          desc = "Terminate";
        };
      }
      {
        mode = "n";
        key = "<leader>du";
        action = "<cmd>lua require('dapui').toggle()<cr>";
        options = {
          silent = true;
          desc = "Dap UI";
        };
      }
      {
        mode = "n";
        key = "<leader>dw";
        action = "<cmd>lua require('dap.ui.widgets').hover()<cr>";
        options = {
          silent = true;
          desc = "Widgets";
        };
      }
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>de";
        action = "<cmd>lua require('dapui').eval()<cr>";
        options = {
          silent = true;
          desc = "Eval";
        };
      }
      {
        mode = "n";
        key = "<leader>df";
        action = "<CMD>lua require('dap.ext.vscode').load_launchjs()<CR><CMD>Telescope dap configurations<CR>";
        options = {
          desc = "Debug Configurations";
        };
      }

      # rust
      {
        mode = "n";
        key = "<leader>rr";
        action = "<CMD>RustRun<CR>";
        options = {
          desc = "Rust run";
        };
      }
      {
        mode = "n";
        key = "<leader>rR";
        action = "<CMD>RustLsp run<CR>";
        options = {
          desc = "Rust run";
        };
      }
      {
        mode = "n";
        key = "<leader>re";
        action = "<CMD>RustLsp explainError<CR>";
        options = {
          desc = "Rust explain error";
        };
      }

    ];
  };
}
