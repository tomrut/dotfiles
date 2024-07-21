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

require('ts_context_commentstring').setup {
  enable_autocmd = false,
}

require('Comment').setup({
 
  pre_hook = function(ctx)
     -- return tsx comment for block mode since ts_context_commentstring does 
     -- not detect correctly location and language specifics
     -- so I use usual visual to comment out tsx, other ways it fallbacks
     -- to what Comment plugin offers for javascript
     if vim.bo.filetype == 'typescriptreact' then
         local U = require('Comment.utils')
         if ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
             return '{/* %s */}'
         else
             return nil
         end
     end
  end
})
