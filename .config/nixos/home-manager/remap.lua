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
vim.keymap.set("n", "<C-PageDown>", vim.cmd.bNext)
vim.keymap.set("n", "<C-PageUp>", vim.cmd.bprevious)


vim.keymap.set('n', '<leader>hs', gitsigns.stage_hunk)
vim.keymap.set('n', '<leader>hr', gitsigns.reset_hunk)
vim.keymap.set('v', '<leader>hs', function() gitsigns.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
vim.keymap.set('v', '<leader>hr', function() gitsigns.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
vim.keymap.set('n', '<leader>hS', gitsigns.stage_buffer)
vim.keymap.set('n', '<leader>hu', gitsigns.undo_stage_hunk)
vim.keymap.set('n', '<leader>hR', gitsigns.reset_buffer)
vim.keymap.set('n', '<leader>hp', gitsigns.preview_hunk)
vim.keymap.set('n', '<leader>hb', function() gitsigns.blame_line{full=true} end)
vim.keymap.set('n', '<leader>tb', gitsigns.toggle_current_line_blame)
vim.keymap.set('n', '<leader>hd', gitsigns.diffthis)
vim.keymap.set('n', '<leader>hD', function() gitsigns.diffthis('~') end)
vim.keymap.set('n', '<leader>td', gitsigns.toggle_deleted)

-- Text object
vim.keymap.set({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')

vim.keymap.set("n", "<leader>gs", vim.cmd.Git)



