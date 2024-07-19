require("tomrut")

-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 0
vim.g.loaded_netrwPlugin = 0

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup()
require('Comment').setup()
