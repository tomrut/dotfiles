require("nvim-tree").setup()
require("mason").setup({
    PATH = "prepend", -- "skip" seems to cause the spawning error
})

