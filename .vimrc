
" buffer navigation
map <C-PageUp> :bp<cr>
map <C-PageDown> :bn<cr>
nnoremap <F5> :buffers<CR>:buffer<Space>

" Plugins
call plug#begin()

" Clojure plugins
"Plug 'clj-kondo/clj-kondo'
"Plug 'tpope/vim-fireplace'
"Plug 'kovisoft/paredit'

Plug 'tpope/vim-fugitive' " the ultimate git helper
Plug 'tpope/vim-commentary' " comment/uncomment lines with gcc or gc in visual mode

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'gruvbox-community/gruvbox'
Plug 'neoclide/coc.nvim'
Plug 'prettier/vim-prettier'
Plug 'tpope/vim-surround'
Plug 'Raimondi/delimitMate'
call plug#end()

" Save remaped to ctrl+s
inoremap <C-S> <Esc>:update<CR>
nnoremap <C-S> :update<CR>

inoremap <silent><expr> <c-space> coc#refresh()
nnoremap <C-n> :Files<CR> " Open file
nnoremap <C-t> :Rg<CR> " Fuzzy search files
nnoremap <C-f> :Buffers<CR> " Search buffers

" block mode since ctrl V is not working - just pasting text
nnoremap q <c-v>

let g:gruvbox_italic=1

" indentation settings
set shiftwidth=2
set autoindent
set smartindent

" when running at every change you may want to disable quickfix
let g:prettier#quickfix_enabled = 0
let g:prettier#config#use_tabs = 'false'

" reformat code on text change and leave of insert mode
autocmd TextChanged,InsertLeave *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.svelte,*.yaml,*.html PrettierAsync

colorscheme gruvbox
set bg=dark    
