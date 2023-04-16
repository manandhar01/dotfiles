" Plugins
so ~/.vim/plugins.vim

nmap <F8> :TagbarTogggle<CR>

" This will enable code folding.
" Use the marker method of folding.
augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END

" Enable Prettier command
command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument

" Disable compatibility with vi which can cause unexpected issues
set nocompatible

" Line Numbering
set relativenumber

" Syntax and Indentation Support
syntax on

" Highlight cursor line underneath the cursor horizontally
set cursorline

" Highlight cursor line underneath the cursor vertically
set cursorcolumn

" Expand tab to spaces
set expandtab

" Set shift width to 2 spaces
set shiftwidth=2

" Set tab width to 2 columns
set tabstop=2

" Use space characters instead of tabs
" set expandtab

" Use highlighting when doing a search
set hlsearch

" Set the commands to save in history (default is 20)
set history=1000

" Theme
set t_Co=256
set bg=dark
colorscheme gruvbox

" Airline status line theme
let g:airline_theme='angr'
let g:airline_powerline_fonts=1

" Indent Guides
let g:indent_guides_enable_on_vim_startup=1

" Turn off error beeping and flashing
" set belloff=all
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" Enable mouse support
set mouse=a

" rainbow_parentheses
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
au Syntax * RainbowParenthesesLoadChevrons

" Always show hidden files in NERDTree
let g:NERDTreeShowHidden=1

" Icons in NERDTree
let g:NERDTreeGitStatusUseXicons=1
let g:NERDTreeGitStatusUseNerdFonts=1

" NERDTree Mappings
silent! nmap <C-p> :NERDTreeToggle<CR>
silent! map <F3> :NERDTreeFind<CR>

let g:NERDTreeMapActivateNode="<F3>"
let g:NERDTreeMapPreview="<F4>"

" ALE
let g:airline#extensions#ale#enabled = 1
let g:ale_set_highlights = 0
let g:ale_linters = {}
let g:ale_fixers = {}
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'
let g:ale_lint_on_text_changed = 'never'

" Different cursor styles in Normal and Insert modes
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
