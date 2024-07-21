require ('nvim-treesitter.configs').setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = { },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = false,

  -- List of parsers to ignore installing (or "all")
  ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },

  ts_context_commentstring = {
      enable = true,
      enable_autocmd = false
  },
}

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


require('nvim-ts-autotag').setup({
  opts = {
    -- Defaults
    enable_close = true, -- Auto close tags
    enable_rename = true, -- Auto rename pairs of tags
    enable_close_on_slash = false -- Auto close on trailing </
  },
  -- Also override individual filetype configs, these take priority.
  -- Empty by default, useful if one of the "opts" global settings
  -- doesn't work well in a specific filetype
  per_filetype = {
    ["html"] = {
      enable_close = false
    }
  }
})

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
