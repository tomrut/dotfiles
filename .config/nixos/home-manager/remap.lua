local wk = require("which-key")
wk.register({
  g = {
    name = "git",
    l = { "<cmd>LazyGit<cr>", "Lazy Git" }, 
    g = { "<cmd>Git<cr>", "Fugitive Git" }, 
  },
  f = {
    name = "file", -- optional group name
    f = { "<cmd>Telescope find_files<cr>", "Find File" }, 
    h = { "<cmd>Telescope help_tags<cr>", "Help tags" },
    b = { "<cmd>Telescope buffers<cr>", "Buffers" },
    g = { "<cmd>Telescope live_grep<cr>", "Live grep" },
  },
}, { prefix = "<leader>" })



vim.g.mapleader = " "
vim.keymap.set("n", "<C-q>", vim.cmd.quit)
vim.keymap.set("n", "<F12>", ':silent !firefox %<CR>')
vim.keymap.set("i", "<F12>", '<Esc>:silent !firefox %<CR>')
vim.keymap.set("n", "<C-s>", vim.cmd.w)
vim.keymap.set("i", "<C-s>", '<Esc>:w<CR>i')
vim.keymap.set("i", "<C-\\>", '<Esc>:NvimTreeToggle<CR>i')
vim.keymap.set("n", "<C-\\>", vim.cmd.NvimTreeToggle)
vim.keymap.set("n", "<Tab>", vim.cmd.bNext)
vim.keymap.set("n", "<S-Tab>", vim.cmd.bprevious)






