local wk = require("which-key")
wk.add({
    { "<leader>f", group = "file" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
    { "<leader>f<Left>", "<cmd>bprevious<cr>", desc = "Previous buffer" },
    { "<leader>f<Right>", "<cmd>bnext<cr>", desc = "Next buffer" },
    { "<leader>f<Up>", "<cmd>new<cr>", desc = "New buffer" },
    { "<leader>f<Down>", "<cmd>bdelete<cr>", desc = "Delete buffer" },
    { "<leader>g", group = "git" },
    { "<leader>gg", "<cmd>Git<cr>", desc = "Fugitive Git" },
    { "<leader>gp", "<cmd>lua require('gitsigns').preview_hunk()<cr>", desc = "Preview hunk" },
    { "<leader>gd", "<cmd>lua require('gitsigns').diffthis()<cr>", desc = "Diffthis" },
    { "<leader>gD", "<cmd>lua require('gitsigns').diffthis('~')<cr>", desc = "Diff this2" },
    { "<leader>gs", "<cmd>lua require('gitsigns').stage_hunk()<cr>", desc = "Stage hunk" },
    { "<leader>gu", "<cmd>lua require('gitsigns').undo_stage_hunk()<cr>", desc = "Undo stage hunk" },
    { "<leader>gr", "<cmd>lua require('gitsigns').reset_hunk()<cr>", desc = "Reset hunk" },
    { "<leader>gS", "<cmd>lua require('gitsigns').stage_buffer()<cr>", desc = "Stage buffer" },
    { "<leader>gR", "<cmd>lua require('gitsigns').reset_buffer()<cr>", desc = "Reset buffer" },
    { "<leader>gb", "<cmd>lua require('gitsigns').blame_line{full=true}<cr>", desc = "Blame lines" },
    { "<leader>gl", "<cmd>LazyGit<cr>", desc = "Lazy Git" },
    { "<leader>t", group = "Toggle" },
    { "<leader>tb", "<cmd>lua require('gitsigns').toggle_current_line_blame()<cr>", desc = "Toggle current line blame" },
    { "<leader>td", "<cmd>lua require('gitsigns').toggle_deleted()<cr>", desc = "Toggle deleted" }
})

vim.g.mapleader = " "
vim.keymap.set("n", "<C-q>", vim.cmd.quit)
vim.keymap.set("n", "<F12>", ':silent !firefox %<CR>')
vim.keymap.set("i", "<F12>", '<Esc>:silent !firefox %<CR>')
vim.keymap.set("n", "<C-s>", vim.cmd.w)
vim.keymap.set("i", "<C-s>", '<Esc>:w<CR>i')
vim.keymap.set("i", "<C-\\>", '<Esc>:NvimTreeToggle<CR>i')
vim.keymap.set("n", "<C-\\>", vim.cmd.NvimTreeToggle)




