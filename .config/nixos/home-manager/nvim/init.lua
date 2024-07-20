require("nvim-web-devicons").setup {}
require("nvim-tree").setup ({
    actions = {
        open_file = {
            window_picker = {
                enable = false 
            }
        }
    }
})
require('lualine').setup({
  options = { theme = 'dracula' }
})

require('Comment').setup()
