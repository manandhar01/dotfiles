" Plugins
so ~/.vim/plugins.vim

nmap <F8> :TagbarToggle<CR>

" This will enable code folding.
" Use the marker method of folding.
augroup filetype_vim
  autocmd!
  autocmd FileType vim setlocal foldmethod=marker
augroup END

" Mapping leader to <space>
let mapleader = " "
let maplocalleader = " "
set showcmd

" Enable Prettier command
command! -nargs=0 Prettier :CocCommand prettier.forceFormatDocument

" Disable compatibility with vi which can cause unexpected issues
set nocompatible

" Line Numbering
set number relativenumber

" Syntax and Indentation Support
syntax on

" Sign column always on
" set signcolumn=yes

" More natural splitting
set splitbelow
set splitright

" Highlight cursor line underneath the cursor horizontally
set cursorline

" Highlight cursor line underneath the cursor vertically
set cursorcolumn

" Expand tab to spaces
set expandtab

" Set shift width to 2 spaces
set shiftwidth=4

" Set tab width to 2 columns
set tabstop=4

" Use highlighting when doing a search
set hlsearch

" Set the commands to save in history (default is 20)
set history=1000

" Prevent automatic commenting
set formatoptions-=cro

" Theme
set t_Co=256
set bg=dark
colorscheme gruvbox
highlight Normal    ctermbg=None
highlight LineNr    ctermbg=None
highlight SignColumn    ctermbg=None

" Airline status line theme
let g:airline_theme='angr'
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
" let g:airline#extensions#tabline#left_sep = ' '
" let g:airline#extensions#tabline#left_alt_sep = '|'
" let g:airline#extensions#tabline#formatter = 'default'
let g:airline#extensions#ale#enabled = 1


" Indent Guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=DarkGray
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=Black

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
silent! nmap <leader>n :NERDTreeToggle<CR>

let g:NERDTreeMapActivateNode="<F3>"
let g:NERDTreeMapPreview="<F4>"

" Different cursor styles in Normal and Insert modes
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" CSS Syntax Highlighting
augroup VimCSS3Syntax
  autocmd!
  autocmd FileType css setlocal iskeyword+=-
augroup END

" Curly underline
hi default CocUnderline cterm=underline gui=undercurl

" Move between tabs
nmap <C-Tab> :tabnext<CR>
nmap <C-S-Tab> :tabprevious<CR>

" NerdTree
autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | end

" mapping for moving lines
" nnoremap <A-j> :m+1<CR>
" nnoremap <A-k> :m-2<CR>
" vnoremap <A-k> :m '<-2<CR>gv=gv'
" vnoremap <A-j> :m '>+1<CR>gv=gv'


" ####### ALE START #######
let g:ale_set_highlights = 0
let g:ale_sign_column_always = 1
let g:ale_ling_on_save = 1
let g:ale_lint_on_enter = 0
let g:ale_lint_on_filetype_changed = 0
let g:ale_lint_on_text_changed = 'never'

let g:ale_linters = { 
      \ 'javascript': ['eslint'] 
      \ }
let g:ale_fixers = {}
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'
let g:ale_lint_on_text_changed = 'never'

nmap <silent> [W <Plug>(ale_first)]<Esc>
nmap <silent> [w <Plug>(ale_previous)]<Esc>
nmap <silent> ]w <Plug>(ale_next)<Esc>
nmap <silent> ]W <plug>(ale_last)<Esc>
nnoremap <Leader>l :ALELint<CR>
" ####### ALE END #######


" ####### GREPPER START #######
let g:grepper = {}
let g:grepper.tools = ['grep', 'git', 'rg']

" nmap gs<plug>(GreppreOperator)
" xmap gs<plug>(GreppreOperator)
nnoremap <Leader>* :Grepper -cword -noprompt<CR>
nnoremap <Leader>g :Grepper -tool git<CR>
nnoremap <Leader>G :Grepper -tool rg<CR>
" ####### GREPPER END #######


" ####### FZF START #######
nnoremap <C-p> :<C-u>FZF<CR>
" ####### FZF END #######


" ####### TERMINAL START #######
tnoremap <M-h> <C-w>h
tnoremap <M-j> <C-w>j
tnoremap <M-k> <C-w>k
tnoremap <M-l> <C-w>l

if has('nvim')
  tnoremap <M-h> <C-\><C-n><C-w>h
  tnoremap <M-j> <C-\><C-n><C-w>j
  tnoremap <M-k> <C-\><C-n><C-w>k
  tnoremap <M-l> <C-\><C-n><C-w>l
  tnoremap <Esc> <C-\><C-n>
  tnoremap <C-v><Esc> <Esc>
endif
" ####### TERMINAL END #######
