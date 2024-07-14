vim.g.mapleader = " "
vim.keymap.set("n", "<C-q>", vim.cmd.quit)
vim.keymap.set("n", "<F12>", ':silent !firefox %<CR>')
vim.keymap.set("i", "<F12>", '<Esc>:silent !firefox %<CR>')
vim.keymap.set("n", "<C-s>", vim.cmd.w)
vim.keymap.set("i", "<C-s>", '<Esc>:w<CR>i')
vim.keymap.set("i", "<C-\\>", '<Esc>:NvimTreeToggle<CR>i')
vim.keymap.set("n", "<C-\\>", vim.cmd.NvimTreeToggle)






