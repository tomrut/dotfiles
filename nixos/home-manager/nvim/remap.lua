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
    { "<leader>gl", "<cmd>LazyGit<cr>", desc = "Lazy Git" }
})

vim.g.mapleader = " "
vim.keymap.set("n", "<C-q>", vim.cmd.quit)
vim.keymap.set("n", "<F12>", ':silent !firefox %<CR>')
vim.keymap.set("i", "<F12>", '<Esc>:silent !firefox %<CR>')
vim.keymap.set("n", "<C-s>", vim.cmd.w)
vim.keymap.set("i", "<C-s>", '<Esc>:w<CR>i')
vim.keymap.set("i", "<C-\\>", '<Esc>:NvimTreeToggle<CR>i')
vim.keymap.set("n", "<C-\\>", vim.cmd.NvimTreeToggle)





